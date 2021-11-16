import 'package:flutter/widgets.dart';

class Keys {
  Keys._();

  static const tabs = Key('__tabs__');
  static const addTodoFab = Key('__addTodoFab__');

  static const todoTab = Key('__todoTab__');
  static const todoList = Key('__todoList__');
  static const todosLoading = Key('__todosLoading__');
  static const snackbar = Key('__snackbar__');
  static const filteredTodosEmptyContainer = Key('__filteredTodosEmptyContainer__');

  static const statsTab = Key('__statsTab__');
  static const emptyStatsContainer = Key('__emptyStatsContainer__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');
  static const statsLoadInProgressIndicator = Key('__statsLoadingIndicator__');

  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const activeFilter = Key('__activeFilter__');
  static const completedFilter = Key('__completedFilter__');

  static const addTodoPage = Key('__addTodoPage__');
  static Key todoItem(String id) => Key('TodoItem__$id');
  static Key todoItemCheckbox(String id) => Key('TodoItem__${id}__Checkbox');
  static Key todoItemTask(String id) => Key('TodoItem__${id}__Task');
  static Key todoItemNote(String id) => Key('TodoItem__${id}__Note');

  static const extraActionsPopupMenuButton = Key('__extraActionsPopupMenuButton__');
  static const extraActionsEmptyContainer = Key('__extraActionsEmptyContainer__');
  static const extraActionsButton = Key('__extraActionsButton__');
  static const toggleAll = Key('__markAllDone__');
  static const clearCompleted = Key('__clearCompleted__');

  static const todoDetailsPage = Key('__todoDetailsPage__');
  static const detailsTodoItemTask = Key('DetailsTodo__Task');
  static const detailsTodoItemNote = Key('DetailsTodo__Note');
  static const deleteTodoButton = Key('__deleteTodoFab__');
  static const detailsPageCheckBox = Key('__detailsPageCheckBox__');
  static const emptyDetailsContainer = Key('__emptyDetailsContainer__');
  static const editTodoFab = Key('__editTodoFab__');

  static const editTodoPage = Key('__editTodoPage__');
  static const saveNewTodo = Key('__saveNewTodo__');
  static const taskField = Key('__taskField__');
  static const noteField = Key('__noteField__');
  static const saveTodoFab = Key('__saveTodoFab__');
}
