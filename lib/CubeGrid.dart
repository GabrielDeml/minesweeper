import 'package:flutter/material.dart';
import 'cell.dart';
import 'cell_widget.dart';

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
      children: [
        for (var i = 0; i < cells.length; i++)
          Row(
            children: [
              for (var j = 0; j < cells[0].length; j++)
                CellWidget(
                  cell: cells[i][j],
                  color: Colors.blue,
                  size: 30,
                ),
            ],
          ),
      ],
    );
  }
}
