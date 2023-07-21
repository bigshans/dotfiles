export async function run(cmd: string | Deno.Command, ...args: string[]) {
    const command =
        cmd instanceof Deno.Command
            ? cmd
            : new Deno.Command(cmd, {
                  args: args,
              });
    const children = command.spawn();
    const { code } = await children.output();
    return code;
}
