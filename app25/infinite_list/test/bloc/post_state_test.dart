// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_list/posts/posts.dart';

void main() {
  group('PostState', () {
    test('supports value comparison', () {
      expect(PostState(), PostState());
      expect(PostState().toString(), PostState().toString());
    });
    test('copies with new values', () {
      final post1 = Post(id: 1, title: 'a', body: 'asd');
      final post2 = Post(id: 2, title: 'b', body: 'qwe');
      final postState = PostState(status: PostStatus.failure, posts: [post1], hasReachedMax: false);

      final result = postState.copyWith(
        status: PostStatus.success,
        posts: postState.posts..add(post2),
        hasReachedMax: true,
      );

      expect(
        result,
        PostState(
          status: PostStatus.success,
          posts: [post1, post2],
          hasReachedMax: true,
        ),
      );
    });
  });
}
