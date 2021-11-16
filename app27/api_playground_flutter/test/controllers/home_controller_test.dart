import 'package:api_playground_flutter/controllers/home_controller.dart';
import 'package:api_playground_flutter/models/todo_model.dart';
import 'package:api_playground_flutter/services/json_placeholder_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final service = JsonPlaceholderServiceMock();
  test('deve preencher a lista corretamente', () async {
    final controller = HomeController(service);
    when(() => service.getTodos()).thenAnswer((invocation) async => [TodoModel(userId: 1, id: 1, title: 'title', completed: true)]);

    await controller.fetchAllTodos();
    expect(controller.todos.length, 1);
  });
}

class JsonPlaceholderServiceMock extends Mock implements JsonPlaceholderService {}
