# Contact List Fake Server

## Rest API

### Urls

|         | /v1/contacts/\<id\>              | /v1/contacts        | /v1/contacts/count |
|---------|----------------------------------|---------------------|--------------------|
| POST    | -                                | ~~create one item~~ | -                  |
| GET     | ~~get one item~~                 | get all items       | get quantity items |
| PUT     | ~~update/replace one item (FD)~~ | update/replace list | -                  |
| PATCH   | ~~update/modify one item (FD)~~  | -                   | -                  |
| DELETE  | ~~delete one item~~              | ~~delete all list~~ | -                  |

FD = FormData

|        | /v1/contacts/\<id\>   | /v1/contacts   | /v1/contacts/count |
|--------|-----------------------|----------------|--------------------|
| POST   | -                     | ~~201~~        | -                  |             
| GET    | ~~200, 404~~          | 200 **         | 200                |
| PUT    | ~~200 or 204**, 404~~ | 200            | -                  |
| PATCH  | ~~200 or 204**, 404~~ | -              | -                  |
| DELETE | ~~204 or 200**, 404~~ | ~~204 or 200~~ | -                  |

204 = no return content

404 = id does not found

\* If has "or", the priority is to use first.

\** Uses pagination, ~~sorting and filtering~~.

### Code samples

`/v1/contacts/1234?page=1`

```dart
final id = request.params['id']; // id = '1234'
final page = request.url.queryParameters['page']; // page = '1'
```

## Commands

to up server by prompt

```
> dart run bin/server.dart
```

to test in android emulator, uses base url `http://10.0.2.2:8080`

to kill process when server is ocupied by this server and it lost connection with VSCode (only in windows)

```
> netstat -ano | findstr :8080
> taskkill /PID <PID> /F
```

## Links

for Rest API:

https://www.restapitutorial.com/lessons/httpmethods.html

https://www.datasyncbook.com/content/handling-deletions/

https://stackoverflow.com/questions/24241893/should-i-use-patch-or-put-in-my-rest-api/37544666#37544666

for markdown:

https://www.tablesgenerator.com/markdown_tables

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

# default readme

A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/` and `/echo/<message>`

# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
Hello, World!
$ curl http://0.0.0.0:8080/echo/I_love_Dart
I_love_Dart
```

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
Hello, World!
$ curl http://0.0.0.0:8080/echo/I_love_Dart
I_love_Dart
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```
