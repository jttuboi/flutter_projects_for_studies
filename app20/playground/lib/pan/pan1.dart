import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Pan1 extends StatelessWidget {
  const Pan1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ZoomContainer(
          zoomLevel: 4,
          imageProvider: Image.asset("assets/img/map/map.png").image,
          objects: [
            MapObject(
              offset: Offset(0, 0),
              size: Size(10, 10),
              child: Container(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class ZoomContainer extends StatefulWidget {
  const ZoomContainer({
    Key? key,
    this.zoomLevel = 1,
    required this.imageProvider,
    this.objects = const [],
  }) : super(key: key);

  final double zoomLevel;
  final ImageProvider<Object> imageProvider;
  final List<MapObject> objects;

  @override
  _ZoomContainerState createState() => _ZoomContainerState();
}

class _ZoomContainerState extends State<ZoomContainer> {
  late double _zoomLevel;
  late ImageProvider _imageProvider;
  late List<MapObject> _objects;

  @override
  void initState() {
    super.initState();
    _zoomLevel = widget.zoomLevel;
    _imageProvider = widget.imageProvider;
    _objects = widget.objects;
  }

  @override
  void didUpdateWidget(covariant ZoomContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ????????????
    if (widget.imageProvider != _imageProvider) {
      _imageProvider = widget.imageProvider;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageViewport(
          zoomLevel: _zoomLevel,
          imageProvider: _imageProvider,
          objects: _objects,
        ),
        // botões para zoom in/out
        Row(children: [
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.zoom_in),
            onPressed: () => setState(() {
              _zoomLevel = _zoomLevel * 2;
            }),
          ),
          SizedBox(width: 5),
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.zoom_out),
            onPressed: () => setState(() {
              _zoomLevel = _zoomLevel / 2;
            }),
          ),
        ]),
      ],
    );
  }
}

class ImageViewport extends StatefulWidget {
  const ImageViewport({
    Key? key,
    required this.zoomLevel,
    required this.imageProvider,
    this.objects = const [],
  }) : super(key: key);

  final double zoomLevel;
  final ImageProvider imageProvider;
  final List<MapObject> objects;

  @override
  _ImageViewportState createState() => _ImageViewportState();
}

class _ImageViewportState extends State<ImageViewport> {
  late double _zoomLevel;
  late ImageProvider _imageProvider;
  late List<MapObject> _objects;

  late ui.Image _image;

  bool _resolved = false;
  bool _denormalized = false;
  Offset _centerOffset = Offset(0, 0);

  late Offset _normalized;
  late double _maxHorizontalDelta;
  late double _maxVerticalDelta;
  late Size _actualImageSize;
  late Size _viewportSize;

  @override
  void initState() {
    super.initState();
    _zoomLevel = widget.zoomLevel;
    _imageProvider = widget.imageProvider;
    _objects = widget.objects;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImageProvider();
  }

  @override
  void didUpdateWidget(covariant ImageViewport oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != _imageProvider) {
      _imageProvider = widget.imageProvider;
      _resolveImageProvider();
    }
    _normalized = Offset(
      (_maxHorizontalDelta == 0) ? 0 : _centerOffset.dx / _maxHorizontalDelta,
      (_maxVerticalDelta == 0) ? 0 : _centerOffset.dy / _maxVerticalDelta,
    );
    _denormalized = true;
    _zoomLevel = widget.zoomLevel;
    _updateActualImageDimensions();
  }

  @override
  Widget build(BuildContext context) {
    print(_objects);
    return !_resolved
        ? SizedBox()
        : LayoutBuilder(
            builder: (context, constraints) {
              _recalculate(constraints.maxWidth, constraints.maxHeight);
              return GestureDetector(
                onPanUpdate: (canReactOnPan) ? handleDrag : null,
                onHorizontalDragUpdate:
                    (canReactOnHorizontalDrag) ? handleDrag : null,
                onVerticalDragUpdate:
                    (canReactOnVerticalDrag) ? handleDrag : null,
                onLongPressEnd: (details) => _addBlueObjectOnMap(details),
                child: Stack(children: [
                  _buildImageMap(),
                  ..._buildObjects(),
                ]),
              );
            },
          );
  }

  List<Widget> _buildObjects() {
    return _objects
        .map(
          (object) => Positioned(
            left: _getLeftPositionFromMapObject(object),
            top: _getTopPositionFromMapObject(object),
            child: GestureDetector(
              onTapUp: (details) {
                late MapObject info;
                info = MapObject(
                  offset: object.offset,
                  size: Size.zero,
                  // não funciona. como está se auto referenciando na função
                  // _removeMapObject(info) sem estar completamente criada,
                  // o valor passado para remover não é ele mesmo.
                  // ainda não sei como consertar isso.
                  child: DecoratedBox(
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Close me"),
                        SizedBox(width: 5),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => _removeMapObject(info),
                        ),
                      ],
                    ),
                  ),
                );
                _addMapObject(info);
              },
              child: Container(
                width: (object.size.isEmpty)
                    ? null
                    : object.size.width * _zoomLevel,
                height: (object.size.isEmpty)
                    ? null
                    : object.size.height * _zoomLevel,
                child: object.child,
              ),
            ),
          ),
        )
        .toList();
  }

  double _getLeftPositionFromMapObject(MapObject object) {
    return _globaltoLocalOffset(object.offset).dx -
        ((object.size.isEmpty) ? 0 : (object.size.width * _zoomLevel) / 2);
  }

  double _getTopPositionFromMapObject(MapObject object) {
    return _globaltoLocalOffset(object.offset).dy -
        ((object.size.isEmpty) ? 0 : (object.size.height * _zoomLevel) / 2);
  }

  void _recalculate(double maxWidth, double maxHeight) {
    _viewportSize = Size(
      math.min(maxWidth, _actualImageSize.width),
      math.min(maxHeight, _actualImageSize.height),
    );
    _maxHorizontalDelta = (_actualImageSize.width - _viewportSize.width) / 2;
    _maxVerticalDelta = (_actualImageSize.height - _viewportSize.height) / 2;
    if (_denormalized) {
      _centerOffset = Offset(
        _maxHorizontalDelta * _normalized.dx,
        _maxVerticalDelta * _normalized.dy,
      );
      _denormalized = false;
    }
  }

  bool get canReactOnPan => _maxHorizontalDelta > 0 && _maxVerticalDelta > 0;

  bool get canReactOnHorizontalDrag =>
      _maxHorizontalDelta > _maxVerticalDelta && !canReactOnPan;

  bool get canReactOnVerticalDrag =>
      !(_maxHorizontalDelta > _maxVerticalDelta) && !canReactOnPan;

  Widget _buildImageMap() {
    return CustomPaint(
      size: _viewportSize,
      painter: MapPainter(_image, _zoomLevel, _centerOffset),
    );
  }

  void _addBlueObjectOnMap(LongPressEndDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(details.globalPosition);
    MapObject newObject = MapObject(
      offset: _localToGlobalOffset(localPosition),
      size: Size(10, 10),
      child: Container(color: Colors.blue),
    );
    _addMapObject(newObject);
  }

  // converte global coordinates do long press para global coordinates relativo ao centro do mapa
  Offset _localToGlobalOffset(Offset value) {
    double dx = value.dx - _viewportSize.width / 2;
    double dy = value.dy - _viewportSize.height / 2;
    double dh = dx + _centerOffset.dx;
    double dv = dy + _centerOffset.dy;
    return Offset(
      dh / (_actualImageSize.width / 2),
      dv / (_actualImageSize.height / 2),
    );
  }

  void handleDrag(DragUpdateDetails updateDetails) {
    Offset newOffset = _centerOffset.translate(
      -updateDetails.delta.dx,
      -updateDetails.delta.dy,
    );
    if (newOffset.dx.abs() <= _maxHorizontalDelta &&
        newOffset.dy.abs() <= _maxVerticalDelta) {
      setState(() {
        _centerOffset = newOffset;
      });
    }
  }

  void _addMapObject(MapObject object) {
    setState(() => _objects.add(object));
  }

  void _removeMapObject(MapObject object) {
    setState(() => _objects.remove(object));
  }

  // aqui onde acontece a recuperação da imagem e a atualização do tamanho
  // é calculado pelo _updateActualImageDimensions()
  void _resolveImageProvider() {
    // o context aqui vem do State
    ImageStream stream =
        _imageProvider.resolve(createLocalImageConfiguration(context));

    // aqui cria a _image para que possa ser desenhado pelo MapPainter
    // o _resolved libera o build da imagem na tela
    // o set state dá o refresh
    stream.addListener(ImageStreamListener((imageInfo, synchronousCall) {
      _image = imageInfo.image;
      _resolved = true;
      _updateActualImageDimensions();
      setState(() {});
    }));
  }

  void _updateActualImageDimensions() {
    _actualImageSize = Size(
      (_image.width / ui.window.devicePixelRatio) * _zoomLevel,
      (_image.height / ui.window.devicePixelRatio) * _zoomLevel,
    );
  }

  // converte global coordinates relativo ao centro do mapa para local coordinates do canto superior esquerdo do viewport
  Offset _globaltoLocalOffset(Offset value) {
    double hDelta = (_actualImageSize.width / 2) * value.dx;
    double vDelta = (_actualImageSize.height / 2) * value.dy;
    return Offset(
      (hDelta - _centerOffset.dx) + (_viewportSize.width / 2),
      (vDelta - _centerOffset.dy) + (_viewportSize.height / 2),
    );
  }
}

class MapObject {
  MapObject({
    required this.offset,
    required this.size,
    required this.child,
  });

  // posição de acordo com o centro do ZoomContainer
  // a posição varia entre -1 a 1, tanto x quanto y
  final Offset offset;
  // tamanho do objeto quando o zoom é o padrão
  final Size size;
  final Widget child;

  @override
  String toString() {
    return "MO($offset, $size)";
  }
}

class MapPainter extends CustomPainter {
  MapPainter(this.image, this.zoomLevel, this.centerOffset);

  final ui.Image image;
  final double zoomLevel;
  final Offset centerOffset;

  @override
  void paint(Canvas canvas, Size size) {
    // recalcula as posições e tamanho para que possa desenhar o mapa no local certo
    double pixelRatio = ui.window.devicePixelRatio;
    Size sizeInDevicePixels = Size(
      size.width * pixelRatio,
      size.height * pixelRatio,
    );
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    Offset centerOffsetInDevicePixels = centerOffset.scale(
      pixelRatio / zoomLevel,
      pixelRatio / zoomLevel,
    );
    Offset centerInDevicePixels = Offset(
      image.width / 2,
      image.height / 2,
    ).translate(
      centerOffsetInDevicePixels.dx,
      centerOffsetInDevicePixels.dy,
    );
    Offset topLeft = centerInDevicePixels.translate(
      -sizeInDevicePixels.width / (2 * zoomLevel),
      -sizeInDevicePixels.height / (2 * zoomLevel),
    );
    Offset rightBottom = centerInDevicePixels.translate(
      sizeInDevicePixels.width / (2 * zoomLevel),
      sizeInDevicePixels.height / (2 * zoomLevel),
    );
    canvas.drawImageRect(
      image,
      Rect.fromPoints(topLeft, rightBottom),
      Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
