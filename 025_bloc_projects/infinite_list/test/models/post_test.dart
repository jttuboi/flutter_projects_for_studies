// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_list/posts/models/models.dart';

void main() {
  group('Post', () {
    test('supports value comparison', () {
      expect(
        Post(id: 1, title: 'post title', body: 'post body'),
        Post(id: 1, title: 'post title', body: 'post body'),
      );
    });
    test('from map', () {
      final postMap = {'id': 1, 'title': 'a', 'body': 'asd'};

      final result = Post.fromMap(postMap);

      expect(result, Post(id: 1, title: 'a', body: 'asd'));
    });
  });
}
