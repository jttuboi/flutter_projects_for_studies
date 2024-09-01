part of 'pl_cubit.dart';

abstract class PlState with EquatableMixin {
  const PlState();

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => true;
}

class PlInitial extends PlState {}
