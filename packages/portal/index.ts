const html = `
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script async src="https://cdn.builder.io/js/webcomponents"></script>
    <style>
      #wrapper {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        margin: 0;
        overflow-x: hidden;
      }
    </style>
  </head>
  <body>
    <builder-component
      id="wrapper"
      model="page"
      v-pre
      api-key="8647192a33eb4fc8aac163e0372c81af" />
  </body>
</html>
`;

export type ResponseSetter = (output: string) => void;

export default function portal(setResponse: ResponseSetter) {
  setResponse(html);
}
