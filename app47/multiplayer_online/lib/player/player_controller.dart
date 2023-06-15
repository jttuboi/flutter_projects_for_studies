// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bonfire/bonfire.dart';
import 'package:multiplayer_online/player/knight_player.dart';
import 'package:multiplayer_online/services/action_message.dart';
import 'package:multiplayer_online/services/direction_message.dart';
import 'package:multiplayer_online/services/message.dart';
import 'package:multiplayer_online/services/message_service.dart';

class PlayerController extends StateController<KnightPlayer> {
  PlayerController({required this.messageService});

  final MessageService messageService;

  @override
  void update(double dt, KnightPlayer component) {}

  void onAttack() {
    messageService.send(Message(
      idPlayer: component!.id,
      action: ActionMessage.attack,
      direction: DirectionMessage.direction(component!.lastDirection),
    ));
  }

  void onMove(double speed, Direction direction) {
    if (speed > 0) {
      sendAction(direction, ActionMessage.move);
    } else {
      sendAction(direction, ActionMessage.idle);
    }
  }

  void sendAction(Direction direction, String action) {
    messageService.send(
      Message(
        idPlayer: component!.id,
        action: action,
        direction: DirectionMessage.direction(direction),
        position: Vector2(component!.x, component!.y),
      ),
    );
  }
}
