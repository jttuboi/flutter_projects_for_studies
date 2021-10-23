import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_list/posts/bloc/post_bloc.dart';
import 'package:infinite_list/posts/views/posts_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key, required this.httpClient}) : super(key: key);

  final http.Client httpClient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider<PostBloc>(
        // o init é iniciado aqui, antes mesmo de construir o scaffold
        create: (context) => PostBloc(httpClient: httpClient)..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
