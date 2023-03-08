import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/CubeGridWidget.dart';
import '../Providers/GridProvider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GridProvider>(builder: (context, gridProvider, child) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CubeGrid(cells: gridProvider.boardState),
            const SizedBox(height: 20),
            // Show the reset button only when the game is over
            (gridProvider.gameOver)
                ? ElevatedButton(
                    onPressed: () {
                      gridProvider.reset();
                    },
                    child: const Text('Reset'),
                  )
                : const SizedBox(height: 0),
            const SizedBox(height: 20),
            Text('Score: ${gridProvider.getScore()}'),
          ],
      );
    });
  }
}
