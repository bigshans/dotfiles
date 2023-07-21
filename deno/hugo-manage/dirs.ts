import { path } from "./deps.ts";
import { LocalFile } from "./file.ts";

export async function getFiles(dir: string) {
    let files: LocalFile[] = [];
    for await (const child of Deno.readDir(dir)) {
        if (child.isFile) {
            files.push(new LocalFile(child.name, dir));
        } else if (child.isDirectory) {
            files = [...files, ...(await getFiles(path.join(dir, child.name)))];
        }
    }
    return files;
}
