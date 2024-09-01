part of 'pf_cubit.dart';

abstract class PfState with EquatableMixin {
  const PfState(this.users);

  final List<String> users;

  @override
  List<Object?> get props => [users];

  @override
  bool? get stringify => true;
}

class PfInitial extends PfState {
  const PfInitial() : super(const []);
}

class PfLoaded extends PfState {
  const PfLoaded(super.users);
}
