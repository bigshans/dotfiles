import { run } from "./cmd.ts";
import { aesDecrypt, aesEncrypt, hmacSHA1 } from "./crypto.ts";
import { existsSync, path } from "./deps.ts";
import { getFiles } from "./dirs.ts";
import {
    LocalFile,
    buildMarkdown,
    encryptHTML,
    parseMarkdown,
} from "./file.ts";
import { Git } from "./git.ts";

export class Hugo {
    private key: string;

    constructor(private blogPath: string) {
        this.key = this.getKey();
    }

    private runHugo(...args: string[]) {
        return run(new Deno.Command("hugo", {
            cwd: this.blogPath,
            args,
        }));
    }

    private getPublicPath() {
        return this.getPath("public");
    }

    private getPrivatePath() {
        return this.getPath("private");
    }

    private getPrivateShadow() {
        return this.getPath("content/private");
    }

    private getPath(p: string) {
        return path.join(this.blogPath, p);
    }

    private getKey() {
        this.key = this.key || Deno.readTextFileSync(this.getPath(".KEY")).replace('\n', '');
        return this.key;
    }

    public async makeHash() {
        const key = this.getKey();
        const shadowPath = this.getPrivateShadow();
        if (!existsSync(shadowPath)) {
            Deno.mkdirSync(shadowPath);
        }
        const shadowFiles = await getFiles(this.getPrivateShadow());
        shadowFiles.forEach((f) => {
            const text = f.getText();
            const info = parseMarkdown(text);
            const hash = hmacSHA1(info.content, key);
            if (hash !== info.meta.hash) {
                info.meta.hash = hash;
                f.writeText(buildMarkdown(info));
            }
        });
    }

    public async compareAndSync() {
        const key = this.getKey();
        const privateFiles = await getFiles(this.getPrivatePath());
        const shadowPath = this.getPrivateShadow();
        if (!existsSync(shadowPath)) {
            Deno.mkdirSync(shadowPath);
        }
        const shadowFiles = await getFiles(this.getPrivateShadow());

        const fileMap: Map<string, LocalFile> = privateFiles.reduce(
            (n, c) => n.set(c.getBasename(), c),
            new Map(),
        );
        const shadowMap: Map<string, LocalFile> = shadowFiles.reduce(
            (n, c) => n.set(c.getBasename(), c),
            new Map(),
        );

        // 如果 private 目录下有，而 shadow 目录下没有，则将文件解密到 shadow 目录
        for (const fileKey of fileMap.keys()) {
            if (!shadowMap.has(fileKey)) {
                const file = fileMap.get(fileKey);
                if (!file) {
                    continue;
                }
                const content = file.getText();
                const info = parseMarkdown(content);
                if (!info.meta.isPrivate) {
                    continue;
                }
                info.content = aesDecrypt(info.content, key);
                const result = buildMarkdown(info);
                const newFile = file.writeText(
                    result,
                    path.join("content/private", file.getBasename()),
                    this.blogPath,
                );
                shadowMap.set(newFile.getBasename(), newFile);
            }
        }

        for (const shadowKey of shadowMap.keys()) {
            const file = shadowMap.get(shadowKey) as LocalFile;
            const info = parseMarkdown(file!.getText());
            if (!info.meta.isPrivate) {
                continue;
            }

            // 如果 shadow 目录下有，而 private 目录下没有，则将文件加密到 private 目录下
            if (!fileMap.has(shadowKey)) {
                if (!info.meta.hash) {
                    info.meta.hash = hmacSHA1(info.content, key);
                    file.writeText(buildMarkdown(info));
                }
                info.content = aesEncrypt(info.content, key);
                console.log(info.meta.hash);
                const result = buildMarkdown(info);
                const newFile = file.writeText(
                    result,
                    path.join(this.getPrivatePath(), file.getBasename())
                );
                fileMap.set(newFile.getBasename(), newFile);
            } else {
                const hash = hmacSHA1(info.content, key);
                const pfile = fileMap.get(shadowKey) as LocalFile;
                const pinfo = parseMarkdown(pfile!.getText());
                if (pinfo.meta.hash !== hash) {
                    // modified private file
                    pinfo.meta.hash = hash;
                    pinfo.content = aesEncrypt(info.content, key);
                    pfile.writeText(buildMarkdown(pinfo));
                    // modified original file
                    info.meta.hash = hash;
                    file.writeText(buildMarkdown(info));
                } else if (pinfo.meta.content !== info.meta.content) {
                    info.content = pinfo.content;
                    pfile.writeText(buildMarkdown(info));
                }
            }
        }
    }

    public async encryptPublic() {
        const publicPath = this.getPublicPath();
        const key = this.getKey();
        const privateFiles = await getFiles(path.join(publicPath, "private"));
        privateFiles.forEach((f) => f.writeText(encryptHTML(f.getText(), key)));
    }

    public async server() {
        await this.compareAndSync();
        await this.onlyServer();
    }

    public async build() {
        await this.compareAndSync();
        await this.runHugo();
        await this.encryptPublic();
        console.log("finished");
    }

    public async onlyServer() {
        await this.runHugo("server");
    }

    public async createFile(filename: string) {
        const filepath = filename.startsWith('private/') ? `content/${filename}.md` : `content/post/${filename}.md`;
        await this.runHugo("new", filepath);
        const file = new LocalFile(this.getPath(filepath));
        const text = file.getText();
        const info = parseMarkdown(text);
        info.meta.hash = hmacSHA1(info.content, this.getKey());
        file.writeText(buildMarkdown(info));
    }

    public async push() {
        await this.build();
        const publicGit = new Git(this.getPublicPath());
        const hugoGit = new Git(this.blogPath);
        await publicGit.add(".");
        await publicGit.commit("-m", "update blog");
        await publicGit.push();

        await hugoGit.add(".");
        await hugoGit.commit("-m", "update website");
        await hugoGit.push();
    }
}
