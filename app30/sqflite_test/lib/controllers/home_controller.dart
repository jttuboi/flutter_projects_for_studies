import 'package:mobx/mobx.dart';
import 'package:sqflite_test/models/contact_model.dart';
import 'package:sqflite_test/repositories/contact_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  @observable
  bool showSearch = false;

  @observable
  ObservableList<ContactModel> contacts = ObservableList<ContactModel>();

  @action
  toggleSearch() {
    showSearch = !showSearch;
  }

  @action
  search(String term) async {
    final repository = ContactRepository();
    var data = await repository.search(term);
    contacts = ObservableList<ContactModel>()..addAll(data);
  }
}
