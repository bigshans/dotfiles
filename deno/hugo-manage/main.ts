import { Hugo } from "./hugo.ts";

function main() {
    const op = Deno.args[0];
    const blogPath = Deno.env.get("BLOG_PATH");
    if (!blogPath) {
        console.log("Absent env BLOG_PATH");
        Deno.exit(1);
    }
    const hugo = new Hugo(blogPath);
    if (op === 'server') {
        hugo.server();
    } else if (op === 'sync') {
        hugo.compareAndSync();
    } else if (op === 'only-server') {
        hugo.onlyServer();
    } else if (op === 'push') {
        hugo.push();
    } else if (op === 'build') {
        hugo.build();
    } else if (op === 'new') {
        hugo.createFile(Deno.args[1]);
    } else if (op === 'hash') {
        hugo.makeHash();
    }
}

if (import.meta.main) {
    main();
}
