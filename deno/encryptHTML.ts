import CryptoJS from "npm:crypto-js";
import { DOMParser } from "https://deno.land/x/deno_dom@v0.1.36-alpha/deno-dom-wasm.ts";

const p = Deno.args[0];
const keyfile = Deno.args[1];

if (!p || !keyfile) {
    console.log("no such file or directory");
    Deno.exit(-1);
}

const h = Deno.readTextFileSync(p);
const key = Deno.readTextFileSync(keyfile).replace(/\n/g, "");

const doc = new DOMParser().parseFromString(h, "text/html");

const pr = doc!.getElementById("private");

if (pr) {
    Deno.exit(0);
}

const body = doc!.body.innerHTML;

const ciphertext = CryptoJS.AES.encrypt(body, key, { mode: CryptoJS.mode.ECB, padding: CryptoJS.pad.ZeroPadding }).toString();

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
const code="${ciphertext}";
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

const newH = h.replace(/<body>(.*)<\/body>/gs, newBody);

Deno.writeTextFileSync(p, newH);
