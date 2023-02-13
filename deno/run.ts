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
  rs: "rustc %f -o temp_%r1 && ./temp_%r1; rm temp_%r1",
  go: "go run %f",
  rkt: "racket %f",
  py: "python %f",
  zsh: "zsh %f",
  cc: "g++ %f -o temp_%r1 && ./temp_%r1; rm temp_%r1",
  cpp: "gcc %f -o temp_%r1 && ./temp; rm temp_%r1",
  c: "gcc %f -o temp_%r1 && ./temp_%r1; rm temp_%r1",
};

if (!commandDict[ft]) {
  console.error("Error: Unknown File Type!");
  Deno.exit(1);
}

const random: Record<string, string> = {};
const command = commandDict[ft].replace(/\%f/g, script)
    .replace(/\%r\d*/g, (match) => {
        if (!random[match]) {
            random[match] = Math.floor(Math.random() * 1000000).toString();
        }
        return random[match].toString();
    });
console.log(`%c$ ${command}`, "font-weight: bold; color: green;");
const p = Deno.run({ cmd: ["bash", "-c", command], cwd: "./" });
await p.status();
