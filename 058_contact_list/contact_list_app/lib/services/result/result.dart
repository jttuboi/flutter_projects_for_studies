// /////////////////////////////////////////////////////////////////////////////
//
// Essas classes foram baseadas do
// https://github.com/spebbe/dartz/blob/master/lib/src/either.dart (MIT)
// https://github.com/Flutterando/result_dart/ (MIT)
//
// /////////////////////////////////////////////////////////////////////////////

import 'package:equatable/equatable.dart';

import 'failure.dart';

abstract class Result<D> {
  const Result();

  R result<R>(R Function(D data) onSuccess, R Function(Failure failure) onFailure);

  bool isSuccess() => result((_) => true, (_) => false);

  bool isFail() => result((_) => false, (_) => true);

  @override
  String toString() => result((data) => 'Success($data)', (failure) => 'Fail($failure)');
}

class Success<D> extends Result<D> with EquatableMixin {
  const Success(D data) : _data = data;

  final D _data;

  @override
  List<Object?> get props => [_data];

  D get value => _data;

  @override
  R result<R>(R Function(D data) onSuccess, R Function(Failure failure) onFailure) {
    return onSuccess(_data);
  }
}

class SuccessOk extends Success<void> {
  const SuccessOk() : super(null);
}

class Fail<D> extends Result<D> with EquatableMixin {
  const Fail(Failure failure) : _failure = failure;

  final Failure _failure;

  @override
  List<Object?> get props => [_failure];

  Failure get value => _failure;

  @override
  R result<R>(R Function(D data) onSuccess, R Function(Failure failure) onFailure) {
    return onFailure(_failure);
  }
}
