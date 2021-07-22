// representa um modelo de dados relacionado a tela
class SignupViewModel {
  String name = '';
  String email = '';
  String password = '';
  bool busy = false;

  @override
  String toString() {
    return 'name=$name email=$email password=$password busy=$busy';
  }
}
