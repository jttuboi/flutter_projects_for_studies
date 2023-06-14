import 'package:bonfire/bonfire.dart';
import 'package:multiplayer_online/abilities/splash_abilities_sprite.dart';
import 'package:multiplayer_online/enemies/goblin_generator_controller.dart';
import 'package:multiplayer_online/enemies/goblin_sprite.dart';
import 'package:multiplayer_online/main.dart';

class GoblinEnemy extends SimpleEnemy with ObjectCollision, UseStateController<GoblinGeneratorController> {
  GoblinEnemy({required Vector2 position})
      : super(
          position: position,
          size: Vector2(tileSize, tileSize),
          speed: 50,
          animation: SimpleDirectionAnimation(
            idleRight: GoblinSprite.idleRight,
            runRight: GoblinSprite.runRight,
            idleLeft: GoblinSprite.idleLeft,
            runLeft: GoblinSprite.runLeft,
          ),
          life: 50,
        ) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(
        size: Vector2(20, 20),
        align: Vector2(6, 15),
      ),
    ]));
  }

  @override
  void update(double dt) {
    seeAndMoveToPlayer(
      closePlayer: (player) {
        simpleAttackMelee(
          damage: 10,
          size: Vector2(40, 40),
          animationRight: SlashAbilitySprite.right,
          direction: lastDirection,
          withPush: true,
        );
      },
      radiusVision: tileSize * 30,
    );
    super.update(dt);
  }

  @override
  void die() {
    controller.respawnMany();
    removeFromParent();
    super.die();
  }
}
