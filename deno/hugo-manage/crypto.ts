import { CryptoJS } from "./deps.ts";

export function hmacSHA1(content: string, key: string): string {
    return CryptoJS.HmacSHA1(content, key).toString();
}

export function aesEncrypt(content: string, key: string): string {
    return CryptoJS.AES.encrypt(content, key, {
        mode: CryptoJS.mode.ECB,
        padding: CryptoJS.pad.ZeroPadding,
    }).toString();
}

export function aesDecrypt(content: string, key: string): string {
    return CryptoJS.AES.decrypt(content, key, {
        mode: CryptoJS.mode.ECB,
        padding: CryptoJS.pad.ZeroPadding,
    }).toString(CryptoJS.enc.Utf8);
}
