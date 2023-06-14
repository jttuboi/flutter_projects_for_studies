import 'package:bonfire/bonfire.dart';

class KnightSprite {
  const KnightSprite._();

  static Future<SpriteAnimation> get idleLeft => _sequenceImage('knight_idle_left.png');

  static Future<SpriteAnimation> get idleRight => _sequenceImage('knight_idle_right.png');

  static Future<SpriteAnimation> get runLeft => _sequenceImage('knight_run_left.png');

  static Future<SpriteAnimation> get runRight => _sequenceImage('knight_run_right.png');

  static Future<SpriteAnimation> get die => _sequenceImage('knight_die.png', amount: 1);

  static Future<SpriteAnimation> _sequenceImage(String filename, {int amount = 6}) async {
    return SpriteAnimation.load(
        'player/$filename',
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: 0.15,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 0),
        ));
  }
}
