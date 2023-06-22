import 'package:flutter/material.dart';
import 'package:infinite_list/posts/posts.dart';
import 'package:http/http.dart' as http;

class App extends MaterialApp {
  App({required http.Client httpClient, Key? key})
      : super(
          key: key,
          home: PostsPage(httpClient: httpClient),
        );
}
