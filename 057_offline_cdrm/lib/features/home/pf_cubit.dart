import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pf_state.dart';

class PfCubit extends Cubit<PfState> {
  PfCubit() : super(const PfInitial());

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(const PfLoaded(['aaa', 'bbb', 'ccc']));
  }
}
