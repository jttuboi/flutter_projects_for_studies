import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:multiplayer_online/enemies/goblin_enemy.dart';
import 'package:multiplayer_online/main.dart';

class GoblinGeneratorController extends StateController<GoblinEnemy> {
  final _positionsToRespawn = [
    Vector2(tileSize * 4, tileSize * 4),
    Vector2(tileSize * 16, tileSize * 4),
    Vector2(tileSize * 4, tileSize * 16),
    Vector2(tileSize * 16, tileSize * 16),
  ];

  final _quantityRespawns = 2;

  @override
  void update(double dt, GoblinEnemy component) {}

  void respawnMany() {
    final random = Random();
    final positions = List<Vector2>.from(_positionsToRespawn);
    int numberOfRespawn = _quantityRespawns;

    while (numberOfRespawn > 0) {
      final indexPosition = random.nextInt(positions.length);
      final position = positions[indexPosition];
      _respawn(position);
      positions.remove(position);
      numberOfRespawn -= 1;
    }
  }

  void _respawn(Vector2 position) {
    final hasGameRef = component?.hasGameRef ?? false;

    if (hasGameRef && !gameRef.camera.isMoving) {
      final goblin = GoblinEnemy(position: position);
      gameRef.add(goblin);
    }
  }
}
