import 'BoardState.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cell.dart';

final gridProvider = StateNotifierProvider<GridProvider, List<List<Cell>>>((ref) {
  return GridProvider();
});

