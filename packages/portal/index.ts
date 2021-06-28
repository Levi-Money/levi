import { serve, serveStatic } from "./deps.ts"

serve({
    // You can serve a single file.
    "/": serveStatic("public/index.html", { baseUrl: import.meta.url }),
    // Or a directory of files.
    "/:filename+": serveStatic("public", { baseUrl: import.meta.url }),
});