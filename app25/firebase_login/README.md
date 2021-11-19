# firebase_login

Para testar esse app, precisa gerar o google-services.json no

https://console.firebase.google.com/

Esse arquivo é gerado quando cria um app com o app name
br.com.tuboistudios.firebase_login.

Após isso, copiar o arquivo gerado na pasta:

`android/app/`

No console do firebase, também criar o Authentication e nele habilitar o Google e Email authentication.

O Google authentication só funcionará se gerar o SHA do app do flutter. Não recomendado para aplicativos que não serão enviados, pois dá um pouco de trabalho.

https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google