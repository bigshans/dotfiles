import { getFiles } from "./dirs.ts";

Deno.test("dir", async () => {
    await getFiles(Deno.cwd());
});
