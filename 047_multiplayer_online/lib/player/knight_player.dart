import 'package:bonfire/bonfire.dart';
import 'package:multiplayer_online/abilities/splash_abilities_sprite.dart';
import 'package:multiplayer_online/main.dart';
import 'package:multiplayer_online/player/knight_sprite.dart';
import 'package:multiplayer_online/player/player_controller.dart';
import 'package:multiplayer_online/services/action_message.dart';

class KnightPlayer extends SimplePlayer with ObjectCollision, UseBarLife, UseStateController<PlayerController> {
  KnightPlayer({required this.id})
      : super(
          position: Vector2(tileSize * 5, tileSize * 5),
          size: Vector2(tileSize, tileSize),
          animation: SimpleDirectionAnimation(
            idleRight: KnightSprite.idleRight,
            runRight: KnightSprite.runRight,
            idleLeft: KnightSprite.idleLeft,
            runLeft: KnightSprite.runLeft,
          ),
        ) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(
        size: Vector2(20, 20),
        align: Vector2(6, 15),
      ),
    ]));
  }

  final String id;

  @override
  void joystickAction(JoystickActionEvent event) {
    if (hasGameRef && !gameRef.camera.isMoving) {
      if (event.event == ActionEvent.DOWN && event.id == 1) {
        controller.onAttack();
        simpleAttackMelee(
          damage: 10,
          size: Vector2(40, 40),
          animationRight: SlashAbilitySprite.right,
          direction: lastDirection,
        );
      }
    }
  }

  @override
  Future<void> die() async {
    final sprite = await KnightSprite.die;
    gameRef.add(
      GameDecoration.withSprite(
        sprite: sprite.getSprite(),
        position: Vector2(position.x, position.y),
        size: Vector2.all(30),
      ),
    );
    removeFromParent();
    super.die();
  }

  @override
  void onMove(double speed, Direction direction, double angle) {
    if (hasController) {
      controller.onMove(speed, direction);
    }
    super.onMove(speed, direction, angle);
  }

  @override
  void idle() {
    if (hasController) {
      controller.sendAction(lastDirection, ActionMessage.idle);
    }
    super.idle();
  }
}
