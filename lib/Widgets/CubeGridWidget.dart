import 'package:flutter/material.dart';

import '../util/Cell.dart';
import 'CellWidget.dart';

class CubeGrid extends StatelessWidget {
  final List<List<Cell>> cells;
  final int sizeOfText;

  const CubeGrid({
    super.key,
    required this.cells,
    this.sizeOfText = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < cells.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var j = 0; j < cells[0].length; j++)
                CellWidget(
                  cell: cells[i][j],
                  size: 30,
                ),
            ],
          ),
      ],
    );
  }
}
