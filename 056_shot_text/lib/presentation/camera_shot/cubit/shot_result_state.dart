part of 'shot_result_cubit.dart';

abstract class ShotResultState extends Equatable {
  const ShotResultState(this.imagePath);

  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

class ShotResultInitial extends ShotResultState {
  const ShotResultInitial(String imagePath) : super(imagePath);
}

class ShotResultTextLoading extends ShotResultState {
  const ShotResultTextLoading(String imagePath) : super(imagePath);
}

class ShotResultTextNotFound extends ShotResultState {
  const ShotResultTextNotFound(String imagePath) : super(imagePath);
}

class ShotResultTextReady extends ShotResultState {
  const ShotResultTextReady(String imagePath, this.text) : super(imagePath);

  final String text;

  @override
  List<Object> get props => [imagePath, text];
}

class ShotResultTextCopiedReady extends ShotResultTextReady {
  const ShotResultTextCopiedReady(String imagePath, String text) : super(imagePath, text);
}

class ShotResultUrlNotOpenedReady extends ShotResultTextReady {
  const ShotResultUrlNotOpenedReady(String imagePath, String text) : super(imagePath, text);
}
