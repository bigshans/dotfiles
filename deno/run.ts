const script = Deno.args[0];
const ft = script.split(".").at(-1);

if (typeof ft === "undefined") {
  Deno.run({ cmd: script.split(" ") });
  Deno.exit(0);
}

const commandDict: Record<string, string> = {
  ts: "ts-node %f",
  js: "node %f",
  sh: "bash %f",
  rs: "rustc %f -o temp && ./temp; rm temp",
  go: "go run %f",
  rkt: "racket %f",
  py: "python %f",
  zsh: "zsh %f",
  cc: "g++ -g %f -o temp && ./temp; rm temp",
  cpp: "g++ -g %f -o temp && ./temp; rm temp",
};

if (!commandDict[ft]) {
  console.error("Error: Unknown File Type!");
  Deno.exit(1);
}

const command = commandDict[ft].replace(/\%f/g, script);
console.log(`%c$ ${command}`, "font-weight: bold; color: green;");
const p = Deno.run({ cmd: ["bash", "-c", command], cwd: "./" });
await p.status();
