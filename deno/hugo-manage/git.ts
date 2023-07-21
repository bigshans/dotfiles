import { run } from "./cmd.ts";

export class Git {
    constructor(private repository: string) {}

    private runCommand(...args: string[]) {
        return run(
            new Deno.Command("git", {
                cwd: this.repository,
                args,
            }),
        );
    }

    public pull(...args: string[]) {
        return this.runCommand("pull", ...args);
    }

    public add(...files: string[]) {
        return this.runCommand("add", ...files);
    }

    public push(...args: string[]) {
        return this.runCommand("push", ...args);
    }

    public commit(...args: string[]) {
        return this.runCommand("commit", ...args);
    }
}
