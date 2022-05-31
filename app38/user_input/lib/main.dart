import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_input/person.dart';

typedef OnReturn = void Function(Person? personReturned)?;

void main() {
  final _appRouter = AppRouter();
  runApp(MyApp(_appRouter));
}

class MyApp extends StatelessWidget {
  const MyApp(this.appRouter, {Key? key}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: appRouter.router.routeInformationParser,
      routerDelegate: appRouter.router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppRouter {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      name: 'HOME',
      path: '/',
      pageBuilder: (context, state) => MaterialPage<void>(child: HomePage()),
      routes: [
        GoRoute(
          name: 'CREATE_PERSON',
          path: 'create_person',
          pageBuilder: (context, state) => MaterialPage<void>(child: CreatePersonGoRouterPage(onReturn: state.extra as OnReturn)),
        ),
      ],
    ),
  ]);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Person person = Person.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('go to create page by Navigator.push()'),
              onPressed: () async {
                // aqui retorna de forma não declarativa, ou seja, utiliza o Navigator do flutter
                final personReturned = await Navigator.push<Person>(
                  context,
                  MaterialPageRoute(builder: (_) => CreatePersonNavigatorPage()),
                );
                print('voltou pelo return');
                setState(() {
                  person = (personReturned != null) ? personReturned : Person.empty();
                });
              },
            ),
            ElevatedButton(
              child: Text('go to create page by GoRouter.push()'),
              onPressed: () async => GoRouter.of(context).pushNamed('CREATE_PERSON', extra: onReturn),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Name: '),
                Text(person.name),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onReturn(Person? personReturned) {
    print('voltou pelo callback');
    setState(() {
      person = (personReturned != null) ? personReturned : Person.empty();
    });
  }
}

class CreatePersonNavigatorPage extends StatelessWidget {
  const CreatePersonNavigatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create person Navigator'), backgroundColor: Colors.red),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.red,
              child: Text('return person via Navigator.pop()'),
              onPressed: () => Navigator.pop(context, Person()),
            ),
            MaterialButton(
              color: Colors.red.shade300,
              child: Text('return null Navigator.pop()'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class CreatePersonGoRouterPage extends StatelessWidget {
  const CreatePersonGoRouterPage({this.onReturn, Key? key}) : super(key: key);

  final OnReturn onReturn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create person GoRouter'), backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.green,
              child: Text('return person via GoRouter.pop()'),
              onPressed: () {
                onReturn?.call(Person());
                GoRouter.of(context).pop();
              },
            ),
            MaterialButton(
              color: Colors.green.shade300,
              child: Text('return null GoRouter.pop()'),
              onPressed: () {
                onReturn?.call(null);
                GoRouter.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
