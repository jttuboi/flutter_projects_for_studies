import 'package:rx_notifier/rx_notifier.dart';

// o RX é bem parecido com o Mobx diferenciando em que o RX pode ter quantas actions quiser no mesmo notifier.
// mas isso pode ser um perigo para grandes projetos, pois se um mesmo arquivo tem N possibilidades,
// os desenvolvedores pode nao saber o que é um e o que é o outro.
// por isso se for utilizar esse package, é recomendado que coloque um limite através
// da arquitetura, dando a possibilidade de um maior controle e manutenção do projeto.
class AppStoreRxNotifier {
  final counter = RxNotifier(0);

  void increment() {
    counter.value++;
  }
}

final appStoreRxNotifier = AppStoreRxNotifier();
