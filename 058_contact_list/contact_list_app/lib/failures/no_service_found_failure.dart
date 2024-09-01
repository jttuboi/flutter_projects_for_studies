import '../services/result/failure.dart';

class NoServiceFoundFailure extends Failure {
  const NoServiceFoundFailure() : super(tag: 'no_service_found', messageForUser: 'O serviço está inválido.');
}
