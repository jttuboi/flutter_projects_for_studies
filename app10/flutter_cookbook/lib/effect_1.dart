import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Effect1 extends StatefulWidget {
  @override
  _Effect1State createState() => _Effect1State();
}

class _Effect1State extends State<Effect1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("download"),
      ),
      body: ListView(),
    );
  }
}

enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
}

// Nota: Cada vez que você define um widget customizado, deve decidir se todas
// as informações relevantes são fornecidas a esse widget de seu pai ou se esse
// widget orquestra o comportamento do aplicativo dentro de si.
// Por exemplo, DownloadButton poderia receber o DownloadStatus atual de seu pai,
// ou DownloadButton poderia orquestrar o próprio processo de download dentro de
// seu objeto State. Para a maioria dos widgets, a melhor resposta é passar as
// informações relevantes de seu pai para o widget, em vez de gerenciar
// o comportamento dentro do widget. Ao passar todas as informações relevantes,
// você garante maior capacidade de reutilização do widget, testes mais fáceis
// e mudanças mais fáceis no comportamento do aplicativo no futuro.

@immutable
class DownloadButton extends StatefulWidget {
  const DownloadButton({
    Key? key,
    required this.status,
    this.transitionDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final DownloadStatus status;
  final Duration transitionDuration;

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool get _isDownloading => widget.status == DownloadStatus.downloading;
  bool get _isFetching => widget.status == DownloadStatus.fetchingDownload;
  bool get _isDownloaded => widget.status == DownloadStatus.downloaded;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _buildButtonShape(child: _buildText()),
      _buildDownloadingProgress(),
    ]);
  }

  Widget _buildButtonShape({required Widget child}) {
    return AnimatedContainer(
      duration: widget.transitionDuration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: _isDownloading || _isFetching
          ? ShapeDecoration(
              shape: const CircleBorder(), // for animate
              color: Colors.white.withOpacity(0.0), // makes invisible
            )
          : const ShapeDecoration(
              shape: StadiumBorder(),
              color: CupertinoColors
                  .lightBackgroundGray, // descobir o qye isso ( ShapeDecoration cinza) impacta
            ), //                                            deve ter algo com a animacao do loading, mas nao sei como funfa
      child: child,
    );
  }

  Widget _buildText() {
    final text = _isDownloaded ? 'OPEN' : 'GET';
    final opacity = _isDownloading || _isFetching ? 0.0 : 1.0;

    //                                                     descobrir como é essa animacao
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedOpacity(
        duration: widget.transitionDuration,
        opacity: opacity,
        curve: Curves.ease,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button?.copyWith(
                fontWeight: FontWeight.bold,
                color: CupertinoColors.activeBlue,
              ),
        ),
      ),
    );
  }

//                                                            o msm vale pra esse, ver como ffunfa o troco
  Widget _buildDownloadingProgress() {
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: widget.transitionDuration,
        opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
        curve: Curves.ease,
        child: _buildProgressIndicator(),
      ),
    );
  }

//                                                            o msm vale pra esse, ver como ffunfa o troco
  Widget _buildProgressIndicator() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white.withOpacity(0.0),
        valueColor: AlwaysStoppedAnimation(CupertinoColors.lightBackgroundGray),
        strokeWidth: 2.0,
        value: null,
      ),
    );
  }
}
