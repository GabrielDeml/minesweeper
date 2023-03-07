import 'package:flutter/foundation.dart' show immutable;

/// A read-only description of a Cell.
@immutable
class Cell {
  const Cell({
    required this.type,
    required this.id,
    this.visible = false,
  });

  final String type;
  final String id;
  final bool visible;

  @override
  String toString() {
    return 'Cell(type: $type, id: $id, visible: $visible)';
  }
}
