// ignore_for_file: avoid_catches_without_on_clauses

import 'package:authentication_repository/src/errors/errors.dart';
import 'package:authentication_repository/src/models/models.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // TODO(a): talvez remover
  @visibleForTesting
  bool isWeb = kIsWeb;

  // TODO(a): talvez remover
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  Stream<User> get user {
    // quando tem alguma mudança no state do google (tipo sign in ou sign out),
    // ele notifica através desse authStateChange()
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = (firebaseUser == null) ? User.empty : firebaseUser.toUser;
      // cria um cache para o usuário logado. se não tiver, loga com um usuario vazio
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  // cria uma nova conta no firebase utilizando email/senha
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  // faz login no firebase pelo google flow
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;

      if (isWeb) {
        // ?? abre aquela página da tela de login do google
        final userCredential = await _firebaseAuth.signInWithPopup(firebase_auth.GoogleAuthProvider());
        credential = userCredential.credential!;
      } else {
        // ??
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  // faz login no firebase por email/senha
  Future<void> logInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  // faz logout
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  // converte o usuario do firebase para o usuario do aplicativo
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
