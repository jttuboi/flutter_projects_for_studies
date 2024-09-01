import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_with_stream/models/ticker.dart';
import 'package:equatable/equatable.dart';

part 'ticker_event.dart';
part 'ticker_state.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  TickerBloc(Ticker ticker) : super(TickerInitial()) {
    // o transformer customiza como o evento deve ser processado
    // restartable() -> Process only one event by cancelling any pending events and processing the new event immediately.
    on<TickerStarted>((event, emit) => _onTickerStarted(event, emit, ticker), transformer: restartable());
    on<_TickerTicked>(_onTickerTicked);
  }

  // é chamado quando clica no botão
  void _onTickerStarted(TickerStarted event, Emitter<TickerState> emit, Ticker ticker) async {
    // onEach possibilita emit ser chamado (de modo assincrono), para cada valor atualizado pelo stream (ticker.tick())
    // o valor transmitido a cada iteração é pelo onData(), nesse caso ele chama um novo _TickerTicked
    await emit.onEach<int>(
      ticker.tick(),
      onData: (tick) => add(_TickerTicked(tick)),
    );

    // após o ticker.tick() terminar de mandar todos os ticks, ele para de executar o onEach
    emit(const TickerComplete());
  }

  void _onTickerTicked(_TickerTicked event, Emitter<TickerState> emit) {
    // é chamado pelo onEach constantemente até acabar, esse manda o valor do ticker para tela
    emit(TickerTickSuccess(event.tick));
  }
}
