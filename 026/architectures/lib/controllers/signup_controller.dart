import 'package:architectures/models/user_model.dart';
import 'package:architectures/repositories/account_repository.dart';
import 'package:architectures/view_models/signup_view_model.dart';

class SignupController {
  SignupController() {
    repository = AccountRepository();
  }

  late AccountRepository repository;

  Future<UserModel> create(SignupViewModel model) async {
    model.busy = true;
    var user = await repository.createAccount(model);
    model.busy = false;
    return user;
  }
}
