import { aesDecrypt, aesEncrypt } from "./crypto.ts";
import { DOMParser, HTMLDocument, path } from "./deps.ts";

export class LocalFile {
    private basicpath: string;

    constructor(
        private filepath: string,
        basicpath?: string,
    ) {
        if (!basicpath) {
            this.basicpath = Deno.cwd();
        }
        this.basicpath = basicpath || Deno.cwd();
        if (!path.isAbsolute(filepath)) {
            this.filepath = path.join(this.basicpath, filepath);
        }
    }

    public getBasename() {
        return path.basename(this.filepath);
    }

    public getPath() {
        return this.filepath;
    }

    public getText() {
        return Deno.readTextFileSync(this.filepath);
    }

    public writeText(content: string, saveAs?: string, basicpath?: string) {
        if (saveAs && !path.isAbsolute(saveAs)) {
            basicpath = basicpath || this.basicpath;
            saveAs = path.join(basicpath, saveAs);
        }
        console.log(saveAs || this.filepath);
        Deno.writeTextFileSync(saveAs || this.filepath, content);
        return (saveAs && new LocalFile(saveAs, basicpath)) || this;
    }

    public copy(to: string, basicpath?: string) {
        if (!path.isAbsolute(to)) {
            basicpath = basicpath || this.basicpath;
            to = path.join(basicpath, to);
        }
        return Deno.copyFileSync(this.filepath, to);
    }

    public rename(to: string, basicpath?: string) {
        if (!path.isAbsolute(to)) {
            basicpath = basicpath || this.basicpath;
            to = path.join(basicpath, to);
        }
        return Deno.renameSync(this.filepath, to);
    }
}

export function parseMarkdown(content: string) {
    const lines = content.split("\n");
    const markdownInfo = {
        content: "",
        meta: {
            isPrivate: false,
            hash: "",
            content: "",
        },
    };
    let metaLines: string[] = [];
    let currentContent: string[] = [];
    let cnt = 0;

    for (const line of lines) {
        if (line === "---") {
            cnt++;
            if (cnt === 2) {
                metaLines = currentContent;
                currentContent = [];
            }
            continue;
        }
        currentContent.push(line);
    }

    for (const meta of metaLines) {
        const _meta = meta.trim();
        if (_meta.startsWith("private: true")) {
            markdownInfo.meta.isPrivate = true;
        }
        if (_meta.startsWith("hash: ")) {
            markdownInfo.meta.hash = _meta.replace("hash: ", "");
        }
    }
    if (!markdownInfo.meta.hash) {
        metaLines.push('hash: ');
    }
    markdownInfo.meta.content = metaLines.join("\n");
    markdownInfo.content = currentContent.join("\n");
    return markdownInfo;
}

export type MarkdownInfo = ReturnType<typeof parseMarkdown>;

export function buildMarkdown(info: MarkdownInfo) {
    return `---\n${info.meta.content.replace(
        /hash: .*/,
        "hash: " + info.meta.hash,
    )}\n---\n${info.content}`;
}

export function encryptHTML(content: string, key: string) {
    const doc = new DOMParser().parseFromString(
        content,
        "text/html",
    ) as HTMLDocument;
    const body = doc.body.innerHTML;
    const cipherText = aesEncrypt(body, key);
    const newBody = `
<body>
<style>
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    width: 100vw;
}
form {
    display: flex;
    gap: 10px;
}
</style>
<div>
<div id="private" style="margin-bottom: 10px;">私人文章，需要密码。点此<a href="" style="color: red;" onclick="history.go(-1)">返回</a>。</div>
<form name="decode">
<input id="key" style="height: 20px;width: 100%;" type="password" name="passowrd" />
</form>
<div style="display: flex;justify-content: space-between;">
<button style="background: #1890FF;color: white;border: none;outline: none;border-radius: 5px;padding: 5px 10px;margin-top: 10px;">提交</button>
<button style="background: white;color: black;border: none;outline: none;border-radius: 5px;padding: 5px 10px;margin-top: 10px;border: 1px solid rgba(0, 0, 0, 0.2);" onclick="history.go(-1)">返回</button>
</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js" integrity="sha512-E8QSvWZ0eCLGk4km3hxSsNmGWbLtSCSUcewDQPQWZF6pEU8GlT8a5fF32wOl1i8ftdMhssTrF/OhyGWwonTcXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
const code="${cipherText}";
const pwd = localStorage.getItem('password');
function decode(key) {
    const bytes = CryptoJS.AES.decrypt(code, key, { mode: CryptoJS.mode.ECB, padding: CryptoJS.pad.ZeroPadding });
    const body = bytes.toString(CryptoJS.enc.Utf8);
    localStorage.setItem("password", key);
    document.body.innerHTML = body;
    filled();
}
function onsubmit() {
    const key = document.getElementById("key").value;
    decode(key);
}
if (pwd) {
    try {
        decode(pwd);
    } catch {
        localStorage.removeItem("password");
        document.querySelector("button").addEventListener("click", onsubmit);
    }
} else {
    document.querySelector("button").addEventListener("click", onsubmit);
}
</script>
</body>
`;
    return content.replace(/<body>(.*)<\/body>/gs, newBody);
}
