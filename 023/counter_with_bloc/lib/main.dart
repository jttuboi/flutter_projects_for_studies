import 'package:counter_with_bloc/counter_bloc.dart';
import 'package:counter_with_bloc/counter_cubit.dart';
import 'package:counter_with_bloc/counter_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _buildProviderCubitPage)),
              child: const Text('com provider/cubit'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _buildNoProviderCubitPage)),
              child: const Text('sem provider/cubit'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _buildProviderBlocPage)),
              child: const Text('com provider/bloc'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _buildNoProviderBlocPage)),
              child: const Text('sem provider/bloc'),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildProviderCubitPage {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: const CounterWithProviderCubitPage(),
    );
  }

  Widget get _buildNoProviderCubitPage {
    return const CounterNoProviderCubitPage();
  }

  Widget get _buildProviderBlocPage {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: const CounterWithProviderBlocPage(),
    );
  }

  Widget get _buildNoProviderBlocPage {
    return const CounterNoProviderBlocPage();
  }
}

class CounterWithProviderCubitPage extends StatelessWidget {
  const CounterWithProviderCubitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('counter cubit')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('este campo não atualiza'),
            BlocBuilder<CounterCubit, int>(
              builder: (context, counter) {
                return Text('atualiza apenas esse counter: $counter');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}

class CounterNoProviderCubitPage extends StatefulWidget {
  const CounterNoProviderCubitPage({Key? key}) : super(key: key);

  @override
  State<CounterNoProviderCubitPage> createState() => _CounterNoProviderCubitPageState();
}

class _CounterNoProviderCubitPageState extends State<CounterNoProviderCubitPage> {
  final _counterCubit = CounterCubit();

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('counter cubit 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('este campo não atualiza'),
            BlocBuilder<CounterCubit, int>(
              bloc: _counterCubit,
              builder: (context, counter) {
                return Text('atualiza apenas esse counter: $counter');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            child: const Icon(Icons.add),
            onPressed: () => _counterCubit.increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
            onPressed: () => _counterCubit.decrement(),
          ),
        ],
      ),
    );
  }
}

class CounterWithProviderBlocPage extends StatelessWidget {
  const CounterWithProviderBlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('counter cubit')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('este campo não atualiza'),
            BlocBuilder<CounterBloc, int>(
              builder: (context, counter) {
                return Text('atualiza apenas esse counter: $counter');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            child: const Icon(Icons.add),
            onPressed: () => BlocProvider.of<CounterBloc>(context).add(Increment()),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
            onPressed: () => BlocProvider.of<CounterBloc>(context).add(Decrement()),
          ),
        ],
      ),
    );
  }
}

class CounterNoProviderBlocPage extends StatefulWidget {
  const CounterNoProviderBlocPage({Key? key}) : super(key: key);

  @override
  State<CounterNoProviderBlocPage> createState() => _CounterNoProviderBlocPageState();
}

class _CounterNoProviderBlocPageState extends State<CounterNoProviderBlocPage> {
  final _counterBloc = CounterBloc();

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('counter cubit 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('este campo não atualiza'),
            BlocBuilder<CounterBloc, int>(
              bloc: _counterBloc,
              builder: (context, counter) {
                return Text('atualiza apenas esse counter: $counter');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            child: const Icon(Icons.add),
            onPressed: () => _counterBloc.add(Increment()),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
            onPressed: () => _counterBloc.add(Decrement()),
          ),
        ],
      ),
    );
  }
}
