part of 'form_validation_bloc.dart';

class FormValidationState extends Equatable {
  const FormValidationState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  // é os dados do state, nesse caso precisa do email, password
  // o status controla como o formulário está se comportando
  final Email email;
  final Password password;
  final FormzStatus status;

  FormValidationState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    // copia os dados do anterior, caso passe algum novo valor, ele modifica
    return FormValidationState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
