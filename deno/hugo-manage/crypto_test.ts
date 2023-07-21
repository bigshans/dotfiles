import { assertEquals } from "https://deno.land/std@0.194.0/testing/asserts.ts";
import { aesDecrypt, aesEncrypt, hmacSHA1 } from "./crypto.ts";

const key = "12345678910111213";
const t = "abcdefghigk";

Deno.test("hmac", () => {
    const first = hmacSHA1(t, key);
    const second = hmacSHA1(t, key);
    assertEquals(first, second);
});

Deno.test("aes", () => {
    const encode = aesEncrypt(t, key);
    const decode = aesDecrypt(encode, key);
    assertEquals(decode, t);
});
