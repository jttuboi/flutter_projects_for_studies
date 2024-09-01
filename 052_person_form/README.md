# Person Form
 
Esse foi um projeto de desafio.
O projeto era fazer uma tela que listasse as pessoas e possibilitasse a adição, edição, remoção e busca de uma pessoa.

Para tela do cadastro, a pessoa deve ter:
- id
- nome
- data de nascimento
- sexo
- endereço
- foto (camera)

O desafio também incluia fazer um servidor em Glassfish para REST API e PostgreSQL, porém para completar esse projeto decidi utilizar o Firebase.

Para testar esse projeto, precisa ter a conta no Firebase.
No [console do Firebase](https://console.firebase.google.com/) precisa gerar o arquivo `google-services.json` através da criação de um acesso para o aplicativo e adicionar o arquivo em `android/app/`.

Nesse projeto foi utilizado packages para acesso ao Firebase, utilizado package do Bloc para o formulário, utilizado package para acesso a Camera.

# Tecnologia

- Flutter 2.5.3 (apenas versão android)
- Dart 2.14.4
- Firebase
