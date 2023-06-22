// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bonfire/bonfire.dart';
import 'package:multiplayer_online/abilities/splash_abilities_sprite.dart';
import 'package:multiplayer_online/enemies/other_player.dart';
import 'package:multiplayer_online/services/action_message.dart';
import 'package:multiplayer_online/services/direction_message.dart';
import 'package:multiplayer_online/services/message.dart';
import 'package:multiplayer_online/services/message_service.dart';

class OtherPlayerController extends StateController<OtherPlayer> {
  OtherPlayerController({required this.messageService});

  final MessageService messageService;
  Direction direction = Direction.right;
  bool isIdle = true;

  @override
  void update(double dt, OtherPlayer component) {
    moveLocal();
  }

  moveLocal() {
    if (isIdle) {
      component!.idle();
      return;
    }
    double speed = component!.speed;
    double speedDiagonal = (speed * Movement.REDUCTION_SPEED_DIAGONAL);
    switch (direction) {
      case Direction.left:
        component!.moveLeft(speed);
        break;
      case Direction.downLeft:
        component!.moveDownLeft(speedDiagonal, speedDiagonal);
        break;
      case Direction.upLeft:
        component!.moveUpLeft(speedDiagonal, speedDiagonal);
        break;
      case Direction.right:
        component!.moveRight(speed);
        break;
      case Direction.downRight:
        component!.moveDownRight(speedDiagonal, speedDiagonal);
        break;
      case Direction.upRight:
        component!.moveUpRight(speedDiagonal, speedDiagonal);
        break;
      case Direction.down:
        component!.moveDown(speed);
        break;
      case Direction.up:
        component!.moveUp(speed);
        break;
      default:
        component!.idle();
        break;
    }
  }

  @override
  void onReady(OtherPlayer component) {
    messageService.onListen(ActionMessage.move, _moveServer);
    messageService.onListen(ActionMessage.idle, _idleServer);
    messageService.onListen(ActionMessage.attack, _attackServer);
    messageService.onListen(ActionMessage.disconnect, _disconnectedEnemyPlayer);
    super.onReady(component);
  }

  void _attackServer(Message message) {
    if (message.idPlayer == component!.id) {
      component!.simpleAttackMelee(
        damage: 10,
        size: Vector2(40, 40),
        interval: 10,
        animationRight: SlashAbilitySprite.right,
        direction: direction,
        withPush: true,
      );
    }
  }

  void _idleServer(Message message) {
    if (message.idPlayer == component!.id) {
      isIdle = true;
      component!.lastDirection = message.direction.toDirection();
      direction = message.direction.toDirection();
    }
  }

  void _moveServer(Message message) {
    if (message.idPlayer == component!.id) {
      isIdle = false;
      component!.position = message.position!;
      direction = message.direction.toDirection();
    }
  }

  void _disconnectedEnemyPlayer(Message message) {
    if (message.idPlayer == component!.id) {
      component!.die();
    }
  }
}
