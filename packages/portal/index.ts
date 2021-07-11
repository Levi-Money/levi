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
    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-5VPD2GH');</script>
    <!-- End Google Tag Manager -->
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
