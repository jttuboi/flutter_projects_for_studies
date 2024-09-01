import '../services/result/failure.dart';

class InternetUnavailableFailure extends Failure {
  const InternetUnavailableFailure()
      : super(tag: 'internet_unavailable', messageForUser: 'O aplicativo está offline, por favor verifique sua conexão com a internet.');
}
