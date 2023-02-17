import CryptoJS from "npm:crypto-js";

const p = Deno.args[0];
const keyfile = Deno.args[1];

if (!p || !keyfile) {
    console.log("no such file or directory");
    Deno.exit(-1);
}

const m = Deno.readTextFileSync(p).split("\n");
const key = Deno.readTextFileSync(keyfile).replace(/\n/g, "");

let cnt = 0;
let pri = false;
const yaml: string[] = [];
const content: string[] = [];

for (const l of m) {
    if (cnt >= 2) {
        content.push(l);
        continue;
    }
    if (l === "---") {
        cnt++;
    }
    if (l === "private: true") {
        pri = true;
    }
    yaml.push(l);
}

if (!pri) {
    Deno.exit(-1);
}

try {
    const bytes = CryptoJS.AES.decrypt(content[0], key);
    const decoded = bytes.toString(CryptoJS.enc.Utf8);
    if (decoded === "") {
        Deno.exit(-1);
    }

    const new_md = [yaml.join("\n"), decoded].join("\n");

    Deno.writeTextFileSync(p, new_md);
} catch {
    // pass
}
