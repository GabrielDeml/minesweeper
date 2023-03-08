import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/GridProvider.dart';
import '../util/Cell.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;
  final double size;

  const CellWidget({
    super.key,
    required this.cell,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: (cell.selected) ? Colors.red : Colors.blue,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Center(
          child: Text(
            cell.visible ? cell.type : ' ',
            style: TextStyle(
              color: Colors.white,
              fontSize: size / 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () {
        context.read<GridProvider>().showCell(cell.x, cell.y);
      },
    );
  }
}
