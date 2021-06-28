const html = `
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script async src="https://cdn.builder.io/js/webcomponents"></script>
    <style>
      #wrapper {
        padding: 0 20px;
        margin: 0 auto;
        max-width: 1200px;
      }
    </style>
  </head>
  <body>
    <builder-component
      id="wrapper"
      model="page"
      v-pre
      api-key="8647192a33eb4fc8aac163e0372c81af" />
    <script>
      document.querySelector('#wrapper').addEventListener('load', (evt) => {
        console.log(evt.data)
      })
    </script>
  </body>
</html>
`;

export type ResponseSetter = (output: string) => void;

export default function portal(setResponse: ResponseSetter) {
  setResponse(html);
}
