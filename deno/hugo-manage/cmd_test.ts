import { assertEquals } from "https://deno.land/std@0.194.0/testing/asserts.ts";
import { run } from "./cmd.ts";

Deno.test("run code", async () => {
    const code = await run("ls", "-la");
    assertEquals(code, 0);
});
