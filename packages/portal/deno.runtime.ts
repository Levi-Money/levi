/// <reference path="../../deps/deployctl/deploy.d.ts" />
import createPortal from "./index.ts";
import type { ResponseSetter } from "./index.ts";

addEventListener("fetch", (event) => {
  const setResponse: ResponseSetter = (output) => {
    event.respondWith(
      new Response(output, {
        status: 200,
        headers: {
          "content-type": "text/html; charset=UTF-8",
        },
      }),
    );
  };
  createPortal(setResponse);
});
