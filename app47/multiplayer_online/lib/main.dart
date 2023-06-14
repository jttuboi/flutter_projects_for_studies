import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer_online/enemies/goblin_enemy.dart';
import 'package:multiplayer_online/enemies/goblin_generator_controller.dart';
import 'package:multiplayer_online/player/knight_player.dart';

const tileSize = 32.0;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BonfireInjector.instance.put((i) => GoblinGeneratorController());

  runApp(const MaterialApp(
    home: Starter(),
  ));
}

class Starter extends StatefulWidget {
  const Starter({super.key});

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      map: WorldMapByTiled(
        'maps/map.json',
        forceTileSize: Vector2(tileSize, tileSize),
      ),
      player: KnightPlayer(),
      joystick: Joystick(
        keyboardConfig: KeyboardConfig(
          keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
        ),
        actions: [
          JoystickAction(
            actionId: 1,
            color: Colors.orange,
            margin: const EdgeInsets.all(40),
          ),
        ],
      ),
      showCollisionArea: true,
      components: [
        GoblinEnemy(position: Vector2(tileSize * 10, tileSize * 10)),
      ],
    );
  }
}
