import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_list/app.dart';
import 'package:infinite_list/posts/posts.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

// void main() {
//   late http.Client httpClient;

//   setUpAll(() {
//     registerFallbackValue(Uri());
//   });

//   setUp(() {
//     httpClient = MockClient();
//   });

//   group('App', () {
//     testWidgets('is a MaterialApp', (tester) async {
//       expect(App(httpClient: httpClient), isA<MaterialApp>());
//     });
//     testWidgets('renders PostsPage', (tester) async {
//       await tester.pumpWidget(App(httpClient: httpClient));
//       await tester.pumpAndSettle();

//       expect(find.byType(PostsPage), findsOneWidget);
//     });
//   });
// }
