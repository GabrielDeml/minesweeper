import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'BoardState.dart';
import 'cell.dart';
import 'providers.dart';

class CellWidget extends HookConsumerWidget {
  final Cell cell;
  final Color color;
  final double size;

  const CellWidget({super.key,
    required this.cell,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: (cell.visible) ? Colors.red : Colors.blue,
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
        ref.read(gridProvider.notifier).toggle(cell.id);
      },
    );
  }
}
