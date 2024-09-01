# Contact List App

This project was created to learn offline-first and synchronization data with a server.

But I included to manipulate files (save locally, download and send to a server) and run integration tests in codemagic as bonus.

The system is simple, it is a CRUD of a contact list where the contact has name, avatar and document. The user can change any of these informations. Name must not be null, avatar is recovered by https url and document must download directly from the server. Usually documents has important information than avatar.

## About

- flutter version: 3.10.1
- dart: 3.0.1
- android sdk version: 33
- ios version: (not used but needs to configure if wants to use it)
- codemagic.io to run integration tests

## Architecture

The project was splitted in `screens`, `widgets`, `blocs`, `entities`, `repositories`, `datasources` and `services`.


The screens represent the page of the app. In this project have contact list page and add/edit/remove contact page.

Widgets represent reusable components.

Blocks is the chosen state management used in this project to control the state of the page. For components, ValueNotifier or similar is usually used.

The entities represent the project model, where the data is stored and there is some logic related to the internal data transformations.

Repositories represent the control of the refactored data passed to the state manager. It is where there is control over where the data comes from offline or online.

The datasources represent the adapters for retrieving data saved somewhere. For example Dio adapters or Sqflite adapters.

Finally, services are external services added to projects, such as Dio and Sqflite or any other internal package that can be reused in other projects. They serve more as a support and not as part of the business, thus being easy to replace with similar ones.

[#############] COLOCAR A IMAGEM AQUI

## Contact list with offline persistence and synchronization on a server

- data are primarily stored locally.
- data is saved and synchronized on the server as if it were a backup.
- data is synchronized with the server every time you ask to synchronize, when you enter the app for the first time and when you change status from offline to online.
- contacts screen shows contact list, delete all button, icon if online or offline.
- the contact screen allows you to add/edit/delete the contact both online and offline.
- errors must be displayed via cafeteria.
- the contact list is an endless list.
- how images and pdfs should be stored in the app and on the server.

- extra: for the server to carry multiple devices, it is necessary for each item to control which devices were synchronized.

## There are 2 types of synchronizations
- list synchronization
    - controls the difference between the local base list and the server list
    - if the lists are the same, then it is synchronized, otherwise it is not synchronized
- an item sync
    - control if an item was added/edited/removed locally but not on the server
    - when it asks to sync the unsynchronized list, the item is synced on the server


## Support

https://www.figma.com/file/Hv1nRdNq4b082O2pVqfopw/Contact-List?type=whiteboard&node-id=0-1

## Links

to download test pdf/pictures:

https://freetestdata.com/

## TODO

- [x] offline-first (crud básico com persistência no sqlite)
- [x] adicionar verificador da internet
- [x] adicionar sincronização com o servidor
- [] adicionar avatar (fazer recuperação via https)
-     falta enviar cada avatar para o servidor e de lá gerar um link para retornar a url do arquivo e sincronizar na base local
- [] adicionar pdf (fazer recuperação via download)
- [] adicionar testes de integração (executar no codemagic)