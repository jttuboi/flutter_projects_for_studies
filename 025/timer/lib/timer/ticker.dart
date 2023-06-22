class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    // o tick começa com um valor alto e vai diminuindo a cada segundo
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1).take(ticks);
  }
}
