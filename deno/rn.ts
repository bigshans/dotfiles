async function exists(filename: string): Promise<boolean> {
  try {
    await Deno.stat(filename);
    // successful, file or directory must exist
    return true;
  } catch (error) {
    if (error instanceof Deno.errors.NotFound) {
      // file or directory does not exist
      return false;
    } else {
      // unexpected error, maybe permissions, pass it along
      throw error;
    }
  }
}

if (Deno.args.length < 2) {
  console.error("E: 缺乏足够的参数");
  Deno.exit(1);
}

const oldPath = Deno.args[0];
const newName = Deno.args[1];

if (!exists(oldPath)) {
  console.error("E: 文件或文件夹不存在");
  Deno.exit(1);
}

const ps = oldPath.split('/')

ps.pop()
ps.push(newName)

await Deno.rename(oldPath, ps.join('/'));
