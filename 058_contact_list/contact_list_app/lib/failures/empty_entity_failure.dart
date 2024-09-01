import '../services/result/failure.dart';

class EmptyEntityFailure extends Failure {
  const EmptyEntityFailure() : super(tag: 'empty_entity', messageForUser: 'Não tem o dado selecionado.');
}
