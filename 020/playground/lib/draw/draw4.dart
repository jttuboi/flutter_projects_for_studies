import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Draw4 extends StatelessWidget {
  const Draw4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppStateEvent()),
        ChangeNotifierProvider(create: (context) => BackgroundProvider()),
      ],
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                BoardWidget(),
                Positioned(right: 0, child: MenuWidget()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BoardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  Color _color = Colors.red;
  bool _isEraserMode = false;
  PointMode _pointMode = PointMode.polygon;
  ImageProvider? _backgroundImage;

  final _histories = PathHistories();
  final _boardGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary isola o repaint para acontecer só nele utilizando o key para referencia
    // o RepaintBoundary ignora o restante, como os botoes do menu
    print("RepaintBoundary");
    return RepaintBoundary(
      key: _boardGlobalKey,
      // preenche o fundo com o background utilizando BoxDecoration
      child: Stack(
        children: [
          Consumer<BackgroundProvider>(
            builder: (context, value, child) {
              print("Consumer<BackgroundProvider>");
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _getBackgroundImage(),
                  ),
                ),
              );
            },
          ),
          // nesse container que tem a imagem, utiliza o GestureDetector para detectar
          // os movimentos para desenhar os traços
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: Consumer<AppStateEvent>(
              builder: (context, value, child) {
                print("Consumer<AppStateEvent>");
                print(value.event);
                // cada vez que um evento é ativado, esse consumer é atualizado
                // ex: quando clica no botão undo, lá ele envia o evento que assim
                // ativa esse consumer. então o _setupEvent() é executado e assim
                // executa os dados relacionados a dar undo nos dados daqui.
                _setupEvent(value.event);
                return ClipRect(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: DrawingPainter(histories: _histories),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    final renderBox = context.findRenderObject() as RenderBox;
    final point = renderBox.globalToLocal(details.globalPosition);

    _histories.startSession(_createPaint(), _pointMode);
    _histories.addPoint(point);

    context.read<AppStateEvent>().send(RepaintEvent());
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final renderBox = context.findRenderObject() as RenderBox;
    final point = renderBox.globalToLocal(details.globalPosition);
    _histories.addPoint(point);
    context.read<AppStateEvent>().send(RepaintEvent());
  }

  void _onPanEnd(DragEndDetails details) {
    _histories.finishSession();
    context.read<AppStateEvent>().send(RepaintEvent());
  }

  void _setupEvent(AppEvent event) {
    if (event is ClearBoardEvent) {
      _clear();
    } else if (event is ChangeColorEvent) {
      _changeColor(event.color);
    } else if (event is ExportImageEvent) {
      _takeScreenshot();
    } else if (event is UndoEvent) {
      _undo();
    } else if (event is RedoEvent) {
      _redo();
    } else if (event is ChangeDrawModeEvent) {
      _changeDrawingMode();
    } else if (event is EraserEvent) {
      _toggleBlendMode();
    } else if (event is ShareEvent) {
      _share();
    } else if (event is ChangeBackgroundEvent) {
      _pickImage();
    } else if (event is FillEvent) {
      _changeBackgroundColor(event.color);
    }
  }

  Paint _createPaint() {
    final color = _isEraserMode ? Colors.transparent : _color;
    final blendMode = _isEraserMode ? BlendMode.clear : BlendMode.srcOver;
    return Paint()
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..blendMode = blendMode
      ..color = color
      ..strokeWidth = 3.0;
  }

  // recupera a imagem no formato de ImageProvider (diferente de Image do Widget)
  ImageProvider _getBackgroundImage() {
    if (_backgroundImage != null) {
      return _backgroundImage!;
    }
    return AssetImage(
      pathOfImages('background.png'),
    );
  }

  // todos os métodos abaixo estão relacionados aos botões. quando clica em algum
  // botão, o evento é enviado, o consumer é atualizado, o _setupEvent é executado
  // aí dependendo do evento executa alguns desses métodos, assim atualizando os
  // dados pertencentes a esse Widget.

  void _clear() {
    // não esá limpando quando clica aqui
    _backgroundImage = null;
    //context.read<BackgroundProvider>().update();

    if (_histories.paths.isEmpty) {
      return;
    }
    _histories.clear();
  }

  void _changeColor(Color color) {
    _color = color.withOpacity(_color.opacity);
  }

  void _undo() {
    _histories.undo();
  }

  void _redo() {
    _histories.redo();
  }

  void _changeDrawingMode() {
    if (_pointMode == PointMode.polygon) {
      _pointMode = PointMode.lines; // cria uma linha tipo dash
    } else if (_pointMode == PointMode.lines) {
      _pointMode = PointMode.points; // cria uma linha pontilhada
    } else {
      _pointMode = PointMode.polygon; // cria uma linha continua
    }
  }

  void _takeScreenshot() {
    if (_histories.paths.isEmpty) {
      return;
    }

    takeScreenShot(_boardGlobalKey);
  }

  void _changeBackgroundColor(Color color) {
    _histories.changeBackgroundColor(color);
  }

  // nenhum local está chamando aqui, então não foi implementado a borracha
  // I don't know why clear mode not working
  void _toggleBlendMode() {
    _isEraserMode = !_isEraserMode;
  }

  Future _pickImage() async {
    // problema após a seleção da imagem pelo imagepicker. o build() está
    // sendo chamado após sair do ImagePicker e o event continua o mesmo, assim
    // chamando esse metodo novamente
    // ainda nao sei como resolver esse problema, pois nao conheço exatamente
    // o pq o ImagePicker manda o build já que nenhum lugar após a construçao do
    // build() chama de novo o build()
    // if (context.read<AppStateEvent>()._event is ChangeBackgroundEvent) {
    //   context.read<AppStateEvent>()._event = NullEvent();
    // }
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    // logo após a seleção o consumer é atualizado pelo setstate.
    // pelo event não mudar, então está encontrando aqui mesmo
    _backgroundImage = FileImage(File(image.path));

    // o build é chamado logo após mudar de tela, por causa disso precisa desativar o evento
    //context.read<BackgroundProvider>().update();
  }

  void _share() {
    Share.share('Flutter Paint'); // chama o menu de share do android
  }
}

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final colorAlert = ColorPickerAlert();
  final fillAlert = ColorPickerAlert();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<AppStateEvent>().send(ClearBoardEvent());
            },
          ),
          IconButton(
            color: colorAlert.currentColor,
            icon: Icon(Icons.palette),
            onPressed: () async {
              final color = Colors.red; //await fillAlert.show(context);
              if (color != null) {
                context.read<AppStateEvent>().send(ChangeColorEvent(color));
              }
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.format_color_fill),
            onPressed: () async {
              final color = Colors.red; //await fillAlert.show(context);
              if (color != null) {
                context.read<AppStateEvent>().send(FillEvent(color));
              }
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.sync_alt),
            onPressed: () {
              context.read<AppStateEvent>().send(ChangeDrawModeEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.save_alt),
            onPressed: () {
              context.read<AppStateEvent>().send(ExportImageEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.undo),
            onPressed: () {
              context.read<AppStateEvent>().send(UndoEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.redo),
            onPressed: () {
              context.read<AppStateEvent>().send(RedoEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.image),
            onPressed: () {
              context.read<AppStateEvent>().send(ChangeBackgroundEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.share),
            onPressed: () {
              context.read<AppStateEvent>().send(ShareEvent());
            },
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
// color picker alert
////////////////////////////////////////////////////////////////////////////////

class ColorPickerAlert {
  Color _currentColor = Colors.red;

  Color get currentColor => _currentColor;

  // Future<Color?> show(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: SingleChildScrollView(
  //           child: ColorPicker(
  //             pickerColor: _currentColor,
  //             onColorChanged: (value) => _currentColor = value,
  //             pickerAreaHeightPercent: 0.8,
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () => Navigator.of(context).pop(_currentColor),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

////////////////////////////////////////////////////////////////////////////////
// custom painter
////////////////////////////////////////////////////////////////////////////////

class DrawingPainter extends CustomPainter {
  final PathHistories _histories;

  DrawingPainter({required PathHistories histories}) : _histories = histories;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      _histories.backgroundPaint,
    );
    for (final path in _histories.paths) {
      canvas.drawPoints(
        path.pointMode,
        path.offsets,
        path.paint,
      );
    }
  }

  // talvez aqui q esteja o problema de chamar o build a todo momento
  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

////////////////////////////////////////////////////////////////////////////////
// path histories
////////////////////////////////////////////////////////////////////////////////

class PathHistory {
  final Paint paint;
  final offsets = <Offset>[];
  final PointMode pointMode;
  PathHistory({required this.paint, required this.pointMode});
}

class PathHistories {
  final _pathHistories = <PathHistory>[];

  final _backupPaths = <PathHistory>[];

  final _backgroundPaint = Paint()..color = Colors.transparent;

  List<PathHistory> get paths => _pathHistories;

  Paint get backgroundPaint => _backgroundPaint;

  void startSession(Paint paint, PointMode pointMode) {
    _pathHistories.add(PathHistory(paint: paint, pointMode: pointMode));

    _backupPaths.clear();
  }

  void addPoint(Offset point) => _pathHistories.last.offsets.add(point);

  void finishSession() {
    if (_pathHistories.last.offsets.length == 1) {
      _pathHistories.last.offsets.add(_pathHistories.last.offsets.first);
    }
  }

  void clear() {
    _pathHistories.clear();
  }

  void undo() {
    if (paths.isEmpty) {
      return;
    }

    final last = paths.removeLast();
    _backupPaths.add(last);
  }

  void redo() {
    if (_backupPaths.isEmpty) {
      return;
    }

    final last = _backupPaths.removeLast();
    _pathHistories.add(last);
  }

  // ignore: use_setters_to_change_properties
  void changeBackgroundColor(Color color) => _backgroundPaint.color = color;
}

////////////////////////////////////////////////////////////////////////////////
// State Management events
////////////////////////////////////////////////////////////////////////////////

abstract class AppEvent {}

class WelcomeAppEvent implements AppEvent {}

class ClearBoardEvent implements AppEvent {}

class ChangeColorEvent implements AppEvent {
  final Color color;

  ChangeColorEvent(this.color);
}

class ExportImageEvent implements AppEvent {}

class UndoEvent implements AppEvent {}

class RedoEvent implements AppEvent {}

class ChangeDrawModeEvent implements AppEvent {}

class EraserEvent implements AppEvent {}

class ShareEvent implements AppEvent {}

class ChangeBackgroundEvent implements AppEvent {}

class RepaintEvent implements AppEvent {}

class NullEvent implements AppEvent {}

class FillEvent implements AppEvent {
  FillEvent(this.color);
  final Color color;
}

class AppStateEvent extends ChangeNotifier {
  AppEvent _event = WelcomeAppEvent();
  AppEvent get event => _event;

  void send(AppEvent event) {
    _event = event;
    notifyListeners();
  }
}

class BackgroundProvider extends ChangeNotifier {
  void update() {
    notifyListeners();
  }
}

////////////////////////////////////////////////////////////////////////////////
// common functions
////////////////////////////////////////////////////////////////////////////////

void takeScreenShot(GlobalKey key) async {
  // precisa da permissão para o acesso ao local que armazenará a imagem
  final permission =
      Platform.isAndroid ? Permission.storage : Permission.photos;
  var status = await permission.request();
  if (status.isPermanentlyDenied) {
    await openAppSettings(); // não está abrindo no emulador
    return;
  }
  if (!status.isGranted) {
    return;
  }
  // converte a tela a partir do RenderRepaintBoundary para pngBytes
  final boundary =
      key.currentContext?.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage();
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  var pngBytes = byteData!.buffer.asUint8List();

  // salva
  await ImageGallerySaver.saveImage(pngBytes);

  // notification
  await Fluttertoast.showToast(
    msg: 'Save image success to gallery',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
  );
}

String pathOfImages(String name) {
  return "assets/img/painter/$name";
}
