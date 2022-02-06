abstract class LoginPresenter {
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<String> get authenticationErrorStream;

  void validateEmail(String email);

  void validatePassword(String password);

  void auth();

  void dispose();
}
