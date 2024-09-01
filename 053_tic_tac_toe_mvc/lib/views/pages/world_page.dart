import 'package:flutter/material.dart';
import 'package:tic_tac_toe_mvc/core/constants.dart';
import 'package:tic_tac_toe_mvc/core/tile_type.dart';
import 'package:tic_tac_toe_mvc/views/interface_controllers/word_controller.dart';
import 'package:tic_tac_toe_mvc/views/widgets/tile.dart';

class WorldPage extends StatefulWidget {
  const WorldPage({required IWorldController worldController, Key? key})
      : _worldController = worldController,
        super(key: key);

  final IWorldController _worldController;

  @override
  State<WorldPage> createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('current: ${widget._worldController.currentPlayer.toTileString}'),
        actions: [
          IconButton(
            tooltip: 'restart',
            icon: const Icon(Icons.autorenew_rounded),
            onPressed: () => setState(widget._worldController.restart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final tile = widget._worldController.tiles[index];
            return (tile.isNone) ? Tile(tile, onTap: () => _markTile(index)) : Tile(tile);
          },
          itemCount: widget._worldController.tiles.length,
        ),
      ),
    );
  }

  void _markTile(int index) {
    setState(() => widget._worldController.markTile(index));
    final winner = widget._worldController.verifyWinner();
    if (!winner.isNone) {
      _showEndGameDialog(winner);
    }
  }

  void _showEndGameDialog(TileType winner) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: winner.isRound ? playerRoundColor.withOpacity(0.5) : playerCrossColor.withOpacity(0.5),
      builder: (context) {
        return AlertDialog(
          title: Text('Player ${winner.toTileString} won!'),
          content: const Text('Click to restart the game.'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: winner.isRound ? playerRoundColor : playerCrossColor),
              onPressed: () {
                setState(widget._worldController.restart);
                Navigator.pop(context);
              },
              child: const Text('restart'),
            ),
          ],
        );
      },
    );
  }
}
