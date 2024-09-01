import 'package:architectures/models/user_model.dart';
import 'package:architectures/view_models/signup_view_model.dart';

class AccountRepository {
  Future<UserModel> createAccount(SignupViewModel model) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return UserModel(
      id: '1',
      name: 'jairo',
      email: 'a@a.com',
      picture: 'https://picsum.photos/200/200',
      role: 'student',
      token: 'asdasd',
    );
  }
}
