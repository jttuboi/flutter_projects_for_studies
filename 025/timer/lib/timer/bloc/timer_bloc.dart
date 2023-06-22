import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timer/timer/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;

  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerTicked>(_onTimerTicked);
    on<TimerPaused>(_onTimerPaused);
    on<TimerResumed>(_onTimerResumed);
    on<TimerReset>(_onTimerReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    // logo que começa, inicia o state TimerRunInProgress()
    emit(TimerRunInProgress(event.duration));

    // cancela o subscription antigo caso ele exista
    _tickerSubscription?.cancel();

    // faz a inscrição nova
    // inicia o tick() e cria o listener para inscrição
    // o tick (que é um stream) associa com evento TimerTicked()
    // a cada mudança de valores feito pelo tick()
    _tickerSubscription = _ticker.tick(ticks: event.duration).listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    // emite TimerRunInProgress() até a duração terminar, assim emitindo o TimerRunComplete()
    emit(event.duration > 0 ? TimerRunInProgress(event.duration) : const TimerRunComplete());
  }

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      // pausa o subscription
      _tickerSubscription?.pause();
      // pausa a parte visual
      emit(TimerRunPause(state.duration));
    }
  }

  void _onTimerResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      // reativa o subscription
      _tickerSubscription?.resume();
      // reativa a parte visual
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    // cancela o subscription
    _tickerSubscription?.cancel();
    // volta para o state initial
    emit(const TimerInitial(_duration));
  }
}
