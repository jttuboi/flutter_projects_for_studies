import 'package:bloc_with_stream/posts/bloc/post_bloc.dart';
import 'package:bloc_with_stream/posts/views/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      // o init é iniciado aqui, antes mesmo de construir o scaffold
      create: (context) => PostBloc(httpClient: http.Client())..add(PostFetched()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Posts')),
        body: const PostsList(),
      ),
    );
  }
}
