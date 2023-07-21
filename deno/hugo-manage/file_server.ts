import { path } from "./deps.ts";

export async function launchServer(port: number, dir?: string) {
    const server = Deno.listen({ port });
    console.log("File server running on http://localhost:8080/");

    for await (const conn of server) {
        handleHttp(conn, dir || Deno.cwd()).catch(console.error);
    }
}

async function handleHttp(conn: Deno.Conn, dir: string) {
  const httpConn = Deno.serveHttp(conn);
  for await (const requestEvent of httpConn) {
    // Use the request pathname as filepath
    const url = new URL(requestEvent.request.url);
    const filepath = path.join(dir, decodeURIComponent(url.pathname));

    // Try opening the file
    let file;
    try {
      file = await Deno.open("." + filepath, { read: true });
    } catch {
      // If the file cannot be opened, return a "404 Not Found" response
      const notFoundResponse = new Response("404 Not Found", { status: 404 });
      await requestEvent.respondWith(notFoundResponse);
      continue;
    }

    // Build a readable stream so the file doesn't have to be fully loaded into
    // memory while we send it
    const readableStream = file.readable;

    // Build and send the response
    const response = new Response(readableStream);
    await requestEvent.respondWith(response);
  }
}
