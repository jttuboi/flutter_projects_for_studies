class Ticker {
  Stream<int> tick() {
    // a cada segundo, o stream envia o valor x, nesse caso começa com 0 e terminará com 9 por causa do take(10)
    return Stream.periodic(const Duration(seconds: 1), (x) => x).take(10);
  }
}
