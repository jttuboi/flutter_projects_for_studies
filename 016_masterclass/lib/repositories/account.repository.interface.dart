import 'package:masterclass/models/user.model.dart';
import 'package:masterclass/view_models/signup.viewmodel.dart';

abstract class IAccountRepository {
  Future<UserModel> createAccount(SignupViewModel viewModel);
}
