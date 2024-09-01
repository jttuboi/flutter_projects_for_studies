import '../services/result/failure.dart';

class EmptyListFailure extends Failure {
  const EmptyListFailure() : super(tag: 'empty_list', messageForUser: 'A lista está vazia.');
}
