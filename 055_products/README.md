# Products

## Sobre o app

Este app lista os produtos alimentícios. Com ele, é possível ver, dar uma avaliação sobre o produto, assim como editar seus dados e remover ele da lista.

## Sobre o projeto

Este projeto foi feito em _Flutter/Dart_ para a geração do app na versão android. Para o armazenamento de dados, foi utilizado o _Firebase_, sendo que o _Cloud Firestore (NoSQL)_ armazena os dados dos produtos e as imagens são armazenadas no _Storage_.

Para suporte ao projeto foi utilizado alguns packages, tanto para o visual, arquitetura, acesso ao _Firebase_ e também para testes e qualidade do projeto.
- para parte visual, o package _image_picker_ foi utilizado para accessar a galeria de imagens do celular do usuário para que ele possa adicioná-la ao editar um produto;
- os packages _select_form_field_ e _flutter_rating_bar_ foram utilizados para facilitar os campos de Tipo de alimento e avaliação do produto, respectivamente; 
- o _BloC_ e _Equatable_ foram utilizados para gerenciamento de estado das páginas. Para página de produtos foi utilizado a arquitetura _BloC_ e para o formulário, foi utilizado a variação _Cubit_;
- para o acesso ao _Firebase_, foi utilizado os packages relacionados ao _Cloud Firestore_ e _Storage_;
- como extra, foi adicionado o package _get_it_ para injeção de dependência.
- e finalmente para os testes e qualidade, foi utilizado o package para testar _BloC_, o _Mocktail_ para ajudar nos testes com base no _Mock_ e o _lint_ para controle de qualidade do código.


## Arquitetura do projeto

O projeto foi baseado no _Clean Architecture_ para ter uma melhor organização do projeto, porém não foi utilizado 100%, pois parte das regras de negócio ficaram na camada presentation. A princípio, ela foi dividida nas camadas presentation, domain e infra.

#### Camada presentation

Ela é dividida por features, neste caso em _products_ e _product_form_. Cada feature contém:
- **Pages:** são as páginas que representam tela da feature.
- **Widgets:** são os componentes que podem ser reutilizados dentro das páginas.
- **View Models:** são os modelos utilizados especificamente para aquela feature.
- **State Managements:** são a parte lógica que contém parte das regras de negócio e também faz o controle do estado das páginas. Para esse projeto, utilizou o nome de bloc e cubit para saber qual tipo de gerenciamento de estado está sendo utilizado na feature.
- **Enums/Utils/Core:** são pastas/arquivos que contém dados/funções para dar suporte à feature.

#### Camada domain

Ela que contém dos dados e regras de negócio. Porém ela ficou mais enxuta para não dar complexidade ao projeto e aproveitar o uso do _State Management_ para executar parte dessas regras.
- **Models:** são os modelos do negócio. Eles que armazenam todas as informações.
- **Repositories/Services:** são apenas interfaces que permitem que o sistema veja sobre os repositories e services. Mais explicação o que são está na camada infra.
- **Enums/Utils/Core:** são pastas/arquivos que contém dados/funções para dar suporte ao sistema inteiro. Um exemplo comum são os dados de configurações do sistema.

#### Camada infra

Essa camada é onde contém o acesso aos dados externos e onde faz a manipulação dos dados para que permita entrar no sistema filtrado com base nos modelos.
- **Repositories:** são as implementações das interfaces da camada domain, em que elas fazem a manipulação dos dados vindo de camadas exteriores.
- **Services:** são as implementações das interfaces da camada domain. Elas podem ser implementações de serviços externos quanto internos. Normalmente é onde implementa o acesso ao banco de dados.


#### Fora da arquitetura

No projeto, existem pastas além da arquitetura.
- o ``android/ios`` são pastas relacionadas ao mobile;
- ``assets`` é a pasta que armazena os dados/imagens utilizadas no projeto;
- ``test`` é a pasta onde contém os testes de unidade/widget;
- ``sandbox`` é onde contém dados extras relacionados ao projeto, porém não utilizados nela, por exemplo, documentos e templates;
- o arquivo ``fill_database.dart`` tem a função de enviar os dados do ``products.json`` e as imagens dos produtos para o _Firebase_ sem a necessidade de incluir manualmente. Para utilizar, é necessário descomentar o código incluso no ``main.dart``, porém use com cautela, pois o processo é demorado e custoso. Comentar a linha após o _Firebase_ estar preenchido.

## Como executar o projeto

- Clone o projeto.
```bash
git@lab.coodesh.com:jttuboi/flutter-20210610.git
```
ou
```bash
https://lab.coodesh.com/jttuboi/flutter-20210610.git
```
- Com o projeto aberto, baixe os packages para o projeto.
```bash
flutter pub get
```
Para esse projeto, foi utilizado o ``Flutter 2.5.3`` e ``Dart 2.14.4``. Caso seja alguma versão diferente, precisará atualizar os packages e versões do _Flutter_ utilizado no ``pubspec.yaml`` no projeto.

- Para fazer a associação desse app com o _Firebase_, é necessário que tenha a conta no _Firebase_.
Entre no [site do _Firebase_](https://console.firebase.google.com/) e crie um projeto e nesse projeto, adicione um app (para Android, iOS não foi testado). Na criação, ele requisitará o nome do package que é ``br.com.tuboistudios.products``. Os outros campos não é necessário preencher. Após isso, ele dará o arquivo ``google-services.json``, que deve ser colocado no projeto em ``android/app/``.
- Ainda no site do _Firebase_, é necessário criar o _Cloud Firestore_ e o _Storage_ entrando nas abas, respectivamente. No _Cloud Firestore_, inicie uma collection chamada ``products`` e no _Storage_, crie uma pasta chamada ``products``.
- Vá ao ``main.dart`` no projeto e descomente a linha com ``await fillDatabase();``.
Esse método é apenas para dar ao Firebase os dados necessários para teste. Execute o projeto e ele criará os dados(*) e após isso ele abrirá o projeto no emulador/dispositivo com android.
- Para executar, utilize o comando abaixo ou faça pela IDE que estiver utilizando.
```bash
flutter build apk
```
**NÃO ESQUEÇA DE COMENTAR A LINHA** ``await fillDatabase();`` após outra execução, para que não fique enviando sempre novos dados. Há dados suficiente para teste e executar apenas uma vez é o necessário.

(*) demora um pouco para enviar os dados. No console ele mostrará _==== INICIOU ENVIO DE DADOS PARA FIREBASE ====_ e terminará quando aparecer _==== FINALIZOU COM SUCESSO ====_.

## Apk pronto para teste

Caso queira executar o app, na pasta [sandbox/](https://lab.coodesh.com/jttuboi/flutter-20210610/-/tree/master/sandbox) contém o arquivo ``app-release.apk``.
- Envie esse arquivo para o dispositivo android.
- Acesse ele via pastas dentro do dispositivo (apps como Files, File Manager e outros dará esse acesso).
- Execute ele para instalar (ele pedirá permissão para execução de apks fora da play store).
- Após instalação, ele mostrará o app na lista de apps.
