import '../services/result/failure.dart';

class TimeoutFailure extends Failure {
  const TimeoutFailure()
      : super(tag: 'timeout', messageForUser: 'O servidor parece não estar respondendo, por favor, tente novamente ou entre mais tarde.');
}
