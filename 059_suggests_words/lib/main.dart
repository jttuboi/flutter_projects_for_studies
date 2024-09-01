import 'package:flutter/material.dart';
import 'package:suggests_words/letter_button.dart';
import 'package:suggests_words/node.dart';
import 'package:suggests_words/number_button.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _letters = ValueNotifier(<String>{});
  final _letterEnabled = ValueNotifier<bool>(true);
  final _numberSelected = ValueNotifier<int>(-1);
  final _words = ValueNotifier(<String>[]);
  final _wordsFiltered = ValueNotifier(<String>[]);

  @override
  void initState() {
    super.initState();
    _numberSelected.addListener(_numberChanged);
  }

  @override
  void dispose() {
    _letters.dispose();
    _letterEnabled.dispose();
    _numberSelected.removeListener(_numberChanged);
    _numberSelected.dispose();
    _words.dispose();
    _wordsFiltered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Row(children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Wrap(direction: Axis.vertical, verticalDirection: VerticalDirection.down, spacing: 2, runSpacing: 8, children: [
                LetterButton('a', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('b', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('c', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('d', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('e', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('f', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('g', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('h', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('i', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('j', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('k', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('l', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('m', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('n', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('o', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('p', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('q', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('r', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('s', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('t', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('u', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('v', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('w', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('x', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('y', enabled: _letterEnabled, onTap: _updateLetters),
                LetterButton('z', enabled: _letterEnabled, onTap: _updateLetters),
              ]),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
              child: ValueListenableBuilder<Set<String>>(
                  valueListenable: _letters,
                  builder: (_, letters, ___) {
                    return Column(children: [
                      for (var i = 0; i < letters.length; i++) NumberButton(i, selected: _numberSelected),
                    ]);
                  }),
            ),
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            child: ValueListenableBuilder<List<String>>(
                valueListenable: _wordsFiltered,
                builder: (_, words, ___) {
                  return ListView.builder(
                    itemBuilder: (_, index) {
                      return Text(words[index]);
                    },
                    itemCount: words.length,
                  );
                }),
          )),
        ]),
      ),
    );
  }

  void _updateLetters(isSelected, letter) {
    if (isSelected) {
      _letters.value = <String>{..._letters.value, letter};
    } else {
      _letters.value = <String>{..._letters.value}..remove(letter);
    }

    _generateWords();

    // coloca um limitante de letras para não sobrecarregar o algoritmo
    // infelizmente o algoritmo é n! (usa recursão)
    _letterEnabled.value = _letters.value.length < 8;
  }

  void _generateWords() {
    final tree = Node('', <Node>[]);

    // adiciona as letras na primeira camada
    for (final letter in _letters.value) {
      tree.nodes.add(Node(letter, <Node>[]));
    }

    _growTree(_letters.value, tree.nodes);

    _words.value = tree.getAllKeys()
      ..remove('')
      ..sort((a, b) => (a.length != b.length) ? a.length.compareTo(b.length) : a.compareTo(b));
    _wordsFiltered.value = _words.value;
  }

  void _growTree(Set<String> letters, List<Node> nodes) {
    for (final node in nodes) {
      for (final letter in letters) {
        if (!node.key.contains(letter)) {
          final newKey = node.key + letter;
          node.nodes.add(Node(newKey, <Node>[]));
        }
      }

      _growTree(letters, node.nodes);
    }
  }

  void _numberChanged() {
    _wordsFiltered.value = _words.value.where((word) => word.length == _numberSelected.value + 1).toList();
  }
}
