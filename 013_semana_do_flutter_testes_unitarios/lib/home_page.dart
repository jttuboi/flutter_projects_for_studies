import 'package:flutter/material.dart';
import 'package:semana_do_flutter_testes_unitarios/bloc_provider.dart';
import 'package:semana_do_flutter_testes_unitarios/person_bloc.dart';
import 'package:semana_do_flutter_testes_unitarios/person_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
        actions: [
          StreamBuilder(
            stream: bloc.stream,
            builder: (context, snapshot) {
              final isEnable = bloc.state is PersonListState &&
                  (bloc.state as PersonListState).data.isNotEmpty;
              return IconButton(
                icon: Icon(Icons.refresh),
                onPressed: isEnable ? () => bloc.add(PersonEvent.clear) : null,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (bloc.state is PersonErrorState) {
              return _ErrorWidget();
            } else if (bloc.state is PersonLoadingState) {
              return CircularProgressIndicator();
            } else {
              return _ListWidget();
            }
          },
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.get(context);
    final textError =
        (bloc.state as PersonErrorState).error?.toString() ?? 'Unknown error';
    return Text(textError);
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.get(context);
    final listPerson = (bloc.state as PersonListState).data;

    if (listPerson.isEmpty) {
      return TextButton(
        onPressed: () => bloc.add(PersonEvent.fetch),
        child: Text('Fecth persons'),
      );
    }

    return ListView.builder(
      itemCount: listPerson.length,
      itemBuilder: (context, index) {
        final item = listPerson[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.isOlder ? 'Maior' : 'Menor' ' de idade'),
        );
      },
    );
  }
}
