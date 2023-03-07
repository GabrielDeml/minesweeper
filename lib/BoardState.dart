
import 'package:riverpod/riverpod.dart';
import 'dart:math';
import 'cell.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// An object that controls a list of [Todo].
class GridProvider extends StateNotifier<List<List<Cell>>> {
  GridProvider() : super([]);

  void buildGrid(int width, int height, double fun) {
    Random random = Random();
    List<List<Cell>> stateTmp = [
      for (var i = 0; i < width; i++) [
        for (var j = 0; j < height; j++)
          Cell(
            type: (random.nextDouble() < fun) ? '_' : 'B',
            id: _uuid.v4(),
            visible: false,
          ),
      ],
    ];

    state = [
      for (var i = 0; i < width; i++) [
        for (var j = 0; j < height; j++)
          Cell(
            type: (stateTmp[i][j].type == 'B') ? 'B' : countBombs(i, j, stateTmp),
            id: stateTmp[i][j].id,
            visible: false,
          ),
      ],
    ];
  }

  String countBombs(int x, int y, List<List<Cell>> stateTmp) {
    int count = 0;
    for (var i = -1; i < 2; i++) {
      for (var j = -1; j < 2; j++) {
        if (x + i >= 0 && x + i < stateTmp.length && y + j >= 0 && y + j < stateTmp[0].length) {
          if (stateTmp[x + i][y + j].type == 'B') {
            count++;
          }
        }
      }
    }
    return count.toString();
  }

  void toggle(String id) {
    state = [
      for (var i = 0; i < state.length; i++)
        [
          for (var j = 0; j < state[i].length; j++)
            Cell(
              type: state[i][j].type,
              id: state[i][j].id,
              visible: (state[i][j].id == id) ? true : state[i][j].visible,
            ),
        ],
    ];
  }

  void toggleAll() {
    state = [
      for (var i = 0; i < state.length; i++)
        [
          for (var j = 0; j < state[i].length; j++)
            Cell(
              type: state[i][j].type,
              id: state[i][j].id,
              visible: true,
            ),
        ],
    ];
  }
}