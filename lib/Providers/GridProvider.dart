import 'dart:math';

import 'package:flutter/material.dart';

import '../util/Cell.dart';


class GridProvider with ChangeNotifier {
  // This is the state of the grid
  List<List<Cell>> boardState = [];
  bool gameOver = false;

  /// This function builds the grid and sets the type of each cell
  void buildGrid(int width, int height, double fun) {
    Random random = Random();
    // Randomly assign each cell a type
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

    // Count the number of bombs around each cell
    for (var i = 0; i < width; i++) {
      for (var j = 0; j < height; j++) {
        boardState[i][j].type =
            (boardState[i][j].type == 'B') ? 'B' : countBombs(i, j);
      }
    }
    gameOver = false;
    notifyListeners();
  }

  /// Reset the game
  void reset() {
    gameOver = false;
    boardState = [];
    notifyListeners();
  }

  /// count the number of bombs around a cell
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

  /// Show the surrounding cells if they are empty
  /// This is recursive so there is no call to notifyListeners()
  void showSurrounding(int i, int j) {
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

  /// Get the score
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

  /// Show the cell and check if the game is over
  void showCell(int i, int j) {
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

  /// Show all the cells
  void toggleAll() {
    for (var i = 0; i < boardState.length; i++) {
      for (var j = 0; j < boardState[i].length; j++) {
        boardState[i][j].visible = true;
      }
    }
    notifyListeners();
  }
}
