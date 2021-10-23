import 'package:bloc_with_stream/posts/views/posts_page.dart';
import 'package:flutter/material.dart';

class App extends MaterialApp {
  const App({Key? key})
      : super(
          key: key,
          home: const PostsPage(),
        );
}
