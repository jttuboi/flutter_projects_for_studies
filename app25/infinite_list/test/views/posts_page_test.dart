import 'package:flutter/material.dart';
import 'package:infinite_list/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

// void main() {
//   group('PostsPage', () {
//     testWidgets('renders PostList', (tester) async {
//       await tester.pumpWidget(MaterialApp(home: PostsPage(httpClient: MockClient())));
//       await tester.pumpAndSettle();

//       expect(find.byType(PostsList), findsOneWidget);
//     });
//   });
// }
