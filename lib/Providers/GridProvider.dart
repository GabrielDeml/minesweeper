import 'dart:math';

import 'package:flutter/material.dart';

import '../util/Cell.dart';

/// An object that controls a list of [Todo].
class GridProvider with ChangeNotifier {
  List<List<Cell>> boardState = [];
  bool gameOver = false;

  void buildGrid(int width, int height, double fun) {
    Random random = Random();
    boardState = [
      for (var i = 0; i < width; i++)
        [
          for (var j = 0; j < height; j++)
            Cell(
              type: (random.nextDouble() < fun) ? '_' : 'B',
              x: i,
              y: j,
              visible: false,
            ),
        ],
    ];

    for (var i = 0; i < width; i++) {
      for (var j = 0; j < height; j++) {
        boardState[i][j].type =
            (boardState[i][j].type == 'B') ? 'B' : countBombs(i, j);
      }
    }
    gameOver = false;
    notifyListeners();
  }

  void reset() {
    gameOver = false;
    boardState = [];
    notifyListeners();
  }

  String countBombs(int x, int y) {
    int count = 0;
    for (var i = -1; i < 2; i++) {
      for (var j = -1; j < 2; j++) {
        if (x + i >= 0 &&
            x + i < boardState.length &&
            y + j >= 0 &&
            y + j < boardState[0].length) {
          if (boardState[x + i][y + j].type == 'B') {
            count++;
          }
        }
      }
    }
    return count.toString();
  }

  void showSurrounding(int i, int j) {
    // If they are empty cells, show the surrounding cells too
    // this has to be it's own function because it's recursive and we don't want to call notifyListeners() every time
    boardState[i][j].visible = true;
    boardState[i][j].selected = true;
    if (boardState[i][j].type == '0') {
      for (var k = -1; k < 2; k++) {
        for (var l = -1; l < 2; l++) {
          if (i + k >= 0 &&
              i + k < boardState.length &&
              j + l >= 0 &&
              j + l < boardState[0].length) {
            if (!boardState[i + k][j + l].visible &&
                boardState[i + k][j + l].type == '0') {
              showSurrounding(i + k, j + l);
            }
          }
        }
      }
    }
  }

  int getScore() {
    int score = 0;
    for (var i = 0; i < boardState.length; i++) {
      for (var j = 0; j < boardState[i].length; j++) {
        if (boardState[i][j].selected && boardState[i][j].type != 'B') {
          score++;
        }
      }
    }
    return score;
  }

  void showCell(int i, int j) {
    // Show the cell
    if (boardState[i][j].type == 'B') {
      boardState[i][j].visible = true;
      gameOver = true;
      toggleAll();
    }
    if (!gameOver) {
      boardState[i][j].visible = true;
      boardState[i][j].selected = true;
      // If they are empty cells, show the surrounding cells too
      if (boardState[i][j].type == '0') {
        showSurrounding(i, j);
      }

      notifyListeners();
    }
  }

  void toggleAll() {
    for (var i = 0; i < boardState.length; i++) {
      for (var j = 0; j < boardState[i].length; j++) {
        boardState[i][j].visible = true;
      }
    }
    notifyListeners();
  }
}
