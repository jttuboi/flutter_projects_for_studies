import 'package:masterclass/models/user.model.dart';
import 'package:masterclass/repositories/account.repository.interface.dart';
import 'package:masterclass/view_models/signup.viewmodel.dart';

class SignupController {
  SignupController(this.repository);

  final IAccountRepository repository;

  Future<UserModel> create(SignupViewModel viewModel) async {
    final UserModel user = await repository.createAccount(viewModel);
    return user;
  }
}
