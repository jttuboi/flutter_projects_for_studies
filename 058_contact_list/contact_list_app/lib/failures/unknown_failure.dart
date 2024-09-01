import '../services/result/failure.dart';

class UnknownFailure extends Failure {
  const UnknownFailure({super.error, super.stackTrace}) : super(tag: 'unknown', messageForUser: 'Erro desconhecido.');
}
