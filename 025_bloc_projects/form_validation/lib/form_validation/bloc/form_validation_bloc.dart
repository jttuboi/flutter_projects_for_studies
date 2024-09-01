import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_validation/form_validation/models/models.dart';
import 'package:form_validation/form_validation/models/password.dart';
import 'package:formz/formz.dart';

part 'form_validation_event.dart';
part 'form_validation_state.dart';

class FormValidationBloc extends Bloc<FormValidationEvent, FormValidationState> {
  FormValidationBloc() : super(const FormValidationState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  @override
  void onTransition(Transition<FormValidationEvent, FormValidationState> transition) {
    // ignore: avoid_print
    print(transition);
    super.onTransition(transition);
  }

  void _onEmailChanged(EmailChanged event, Emitter<FormValidationState> emit) {
    // chega a string com o email e transforma-o em dirty (ou seja, o conteudo foi modificado)
    final email = Email.dirty(event.email);

    emit(state.copyWith(
      // se o email está valido, ele manda email modificado
      // se o email está invalido, ele converte para puro dizendo que esse email não é mais modificado
      //pq??????????????????????????????
      // o validator() implementado no Email
      // ele retorna null quando dá match (quando é null, o .valid retorna true)
      // retorn enum invalid quando não dá match (quando é qqr outra coisa, o .valid retorna false)
      email: email.valid ? email : Email.pure(event.email),
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<FormValidationState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password.valid ? password : Password.pure(event.password),
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<FormValidationState> emit) {
    // chega a string com o email e transforma-o em dirty (ou seja, o conteudo foi modificado)
    final email = Email.dirty(state.email.value);
    // envia o novo state com o novo email (o password copia do state antigo)
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
      // cria o status de valido ou não dependendo do email e do password
      // pode ter outros status como se está submetendo o form coms ucesso e outros (ver no FormzStatus)
    ));
  }

  void _onPasswordUnfocused(PasswordUnfocused event, Emitter<FormValidationState> emit) {
    // chega a string com o password e transforma-o em dirty (ou seja, o conteudo foi modificado)
    final password = Password.dirty(state.password.value);

    // envia o novo state com o novo password (o email copia do state antigo)
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<FormValidationState> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    // emit o email e password sujos, ou seja, foram modificados
    emit(state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    ));
    // só libera para emitir apos ele estar valido
    if (state.status.isValidated) {
      // aqui emit que está na fase de envio (o duration simula o tempo de processamento do envio)
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 1));

      // apos o envio, ele muda de estado para sucesso
      emit(state.copyWith(status: FormzStatus.submissionSuccess));

      // obs: o email e password continua como dirty
      // pq???????????
    }
  }
}
