import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        // inicia como autenticação desconhecida
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    // cria um stream para autenticação
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) async {
    if (event.status.isUnauthenticated) {
      return emit(const AuthenticationState.unauthenticated());
    }
    if (event.status.isAuthenticated) {
      final user = await _tryGetUser();
      return emit(user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated());
    }
    return emit(const AuthenticationState.unknown());
  }

  void _onAuthenticationLogoutRequested(AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (e) {
      return null;
    }
  }
}
