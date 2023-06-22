import 'package:bonfire/bonfire.dart';
import 'package:multiplayer_online/enemies/other_player_controller.dart';
import 'package:multiplayer_online/main.dart';
import 'package:multiplayer_online/player/knight_sprite.dart';

class OtherPlayer extends SimpleEnemy with ObjectCollision, UseBarLife, UseStateController<OtherPlayerController> {
  OtherPlayer({required this.id, required Vector2 position, required Direction direction})
      : super(
          initDirection: direction,
          position: position,
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
}
