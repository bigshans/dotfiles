import * as path from "https://deno.land/std@0.194.0/path/mod.ts";
import { existsSync } from "https://deno.land/std@0.194.0/fs/mod.ts";
import CryptoJS from "npm:crypto-js";
import {
    DOMParser,
    HTMLDocument,
} from "https://deno.land/x/deno_dom@v0.1.36-alpha/deno-dom-wasm.ts";

export { path, CryptoJS, DOMParser, HTMLDocument, existsSync };
