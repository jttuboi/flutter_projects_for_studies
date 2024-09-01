import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer_online/enemies/other_player.dart';
import 'package:multiplayer_online/enemies/other_player_controller.dart';
import 'package:multiplayer_online/player/knight_player.dart';
import 'package:multiplayer_online/player/player_controller.dart';
import 'package:multiplayer_online/services/action_message.dart';
import 'package:multiplayer_online/services/direction_message.dart';
import 'package:multiplayer_online/services/message.dart';
import 'package:multiplayer_online/services/message_service.dart';
import 'package:multiplayer_online/services/web_socket_service.dart';
import 'package:uuid/uuid.dart';

const tileSize = 32.0;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final websocket = WebsocketService();

  //BonfireInjector.instance.put((i) => GoblinGeneratorController());
  BonfireInjector.instance.put((i) => websocket);
  BonfireInjector.instance.put((i) => MessageService(websocket: i.get()));
  BonfireInjector.instance.put((i) => PlayerController(messageService: i.get()));
  BonfireInjector.instance.putFactory((i) => OtherPlayerController(messageService: i.get()));

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
  late final GameController gameController;
  late final MessageService messageService;
  late final String id;

  @override
  void initState() {
    id = const Uuid().v1();
    gameController = GameController();
    messageService = BonfireInjector.instance.get();
    messageService.init();
    messageService.onListen(ActionMessage.enemyInvocation, _addOtherPlayerAndSendMyLocation);
    messageService.onListen(ActionMessage.previouslyEnemyConnected, _addOtherPlayerThatAlreadyOnMap);
    super.initState();
  }

  @override
  void dispose() {
    messageService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      gameController: gameController,
      map: WorldMapByTiled(
        'maps/map.json',
        forceTileSize: Vector2(tileSize, tileSize),
      ),
      player: KnightPlayer(id: id),
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
      components: const [
        // GoblinEnemy(position: Vector2(tileSize * 10, tileSize * 10)),
      ],
      onReady: (gameRef) {
        // manda a posição desde jogador para o servidor atualizar outros apps
        messageService.send(
          Message(
            idPlayer: id,
            action: ActionMessage.enemyInvocation,
            direction: DirectionMessage.right,
            position: Vector2(gameRef.player!.position.x, gameRef.player!.position.y),
          ),
        );
      },
    );
  }

  void _addOtherPlayerAndSendMyLocation(Message message) {
    // cria e adiciona o outro jogador quando ele enviar a msg para este app
    _addOtherPlayer(message);

    // manda de volta para o outro jogador q estou aqui, pois ele precisa saber quem já está no mapa
    messageService.send(
      Message(
        idPlayer: id,
        action: ActionMessage.previouslyEnemyConnected,
        direction: DirectionMessage.direction(gameController.player!.lastDirection),
        position: gameController.player!.position,
      ),
    );
  }

  void _addOtherPlayerThatAlreadyOnMap(Message message) {
    // este serve para barrar outros players adicionais. este exemplo é 1x1
    final hasOtherPlayer = gameController.gameRef.componentsByType<OtherPlayer>().any((element) => element.id == message.idPlayer);

    // quando entrou no mapa, podem ter outros jogadores, então recebe as msgs dos outros jogadores e atualiza
    if (!hasOtherPlayer) {
      _addOtherPlayer(message);
    }
  }

  void _addOtherPlayer(Message message) {
    final otherPlayer = OtherPlayer(
      id: message.idPlayer,
      position: message.position!,
      direction: message.direction.toDirection(),
    );
    gameController.addGameComponent(otherPlayer);
  }
}
