import 'package:bonfire/bonfire.dart';

class GoblinSprite {
  const GoblinSprite._();

  static Future<SpriteAnimation> get idleLeft => _sequenceImage('goblin_idle_left.png');

  static Future<SpriteAnimation> get idleRight => _sequenceImage('goblin_idle_right.png');

  static Future<SpriteAnimation> get runLeft => _sequenceImage('goblin_run_left.png');

  static Future<SpriteAnimation> get runRight => _sequenceImage('goblin_run_right.png');

  static Future<SpriteAnimation> _sequenceImage(String filename) {
    return SpriteAnimation.load(
        'enemies/$filename',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 0),
        ));
  }
}
