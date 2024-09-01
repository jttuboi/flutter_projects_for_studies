import 'package:bonfire/bonfire.dart';

class Message {
  Message({
    required this.idPlayer,
    required this.action,
    required this.direction,
    this.position,
  });

  final String idPlayer;
  final String action;
  final String direction;
  final Vector2? position;

  Map<String, dynamic> toJson() {
    return {
      'id': idPlayer,
      'action': action,
      'direction': direction,
      'position': position != null
          ? {
              'x': position!.x,
              'y': position!.y,
            }
          : null,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        idPlayer: json['id'],
        action: json['action'],
        direction: json['direction'],
        position: json['position'] != null
            ? Vector2(
                double.parse(json['position']['x'].toString()),
                double.parse(json['position']['y'].toString()),
              )
            : null,
      );
}
