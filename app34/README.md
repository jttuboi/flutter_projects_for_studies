# login com cliente e servidor

### server

O servidor foi feito em dart para suprir via REST API a parte de autenticação por JWT.

basta apenas dar start que ele inicia o servidor.

a url é http://localhost:4040/

as urls da API é
-----------------------------------------------
POST -> http://localhost:4040/api/login

headers -> {
	"Content-Type": "application/json"
}

body -> {
  "username": "user_a",
  "password": "123123",
  "email": "a@a.com"
}

return -> {
	"authenticated":true,
	"token":"TOKEN_NO_FORMATO_JWT",
	"message":"OK"
}
-----------------------------------------------
GET -> http://localhost:4040/api/todos

headers -> {
	"Content-Type": "application/json",
	"Authorization": "Bearer TOKEN_NO_FORMATO_JWT"
}

return -> [
	{"title":"titulo 1","message":"mensagem 1","completed":true},
	{"title":"titulo 2","message":"mensagem 2","completed":false},
	{"title":"titulo 3","message":"mensagem 3","completed":true},
	{"title":"titulo 4","message":"mensagem 4","completed":false}
]

### cliente

o app foi feito em flutter, cujo contém apenas a pagina de login e a pagina de todos.

o objetivo é logar e mostrar a página de todos apos sucesso no login.

versão utilizada android SDK 30, flutter 2.8.1.

para iniciar, precisa ter o emulador do android maior que 16 e menor que 31 (recomendado usar 30).

na pagina de login, digitar no username: user_a e no password: 123123 para logar.

para dar erro no login, basta digitar qualquer coisa diferente disso.

após logar, ele irá requisitar os dados de todo do servidor utilizando o token já obtido após login.

### Comentários

Esse exemplo foi baseado do https://www.youtube.com/watch?v=kQ_hShOrzHM.

O login é bem simples, não tem validação, não tem arquitetura nenhuma, os dados são crus e não tratados com exceção da parte de autenticação, pois esse foi o foco de fazer esse tutorial.

Foi feito um servidor em dart bem simples apenas para simular uma API.
