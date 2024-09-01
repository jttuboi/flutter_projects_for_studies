import 'package:masterclass/models/user.model.dart';
import 'package:masterclass/repositories/account.repository.interface.dart';
import 'package:masterclass/view_models/signup.viewmodel.dart';

class AccountRepository implements IAccountRepository {
  @override
  Future<UserModel> createAccount(SignupViewModel viewModel) async {
    // simulando o tempo de demora de um acesso ao servidor
    await Future.delayed(const Duration(milliseconds: 3000));
    return UserModel(
      id: '1',
      name: 'Bill',
      email: 'bill@bill.com',
      picture: 'https://picsum.photos/200/200',
      role: 'student',
      token: 'xpto',
    );
  }
}
