/// <reference path="../../deps/deployctl/deploy.d.ts" />

addEventListener("fetch", (event) => {
    event.respondWith(
        new Response("Hello from Levi", {
            status: 200,
            headers: {
                server: "denosr",
                "content-type": "text/plain",
            },
        }),
    );
});