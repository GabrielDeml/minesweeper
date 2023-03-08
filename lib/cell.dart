class Cell {
  Cell({
    required this.type,
    required this.x,
    required this.y,
    this.visible = false,
    this.selected = false,
  });

  String type;
  final int x;
  final int y;
  bool visible;
  bool selected;

  @override
  String toString() {
    return 'Cell(type: $type, x: $x, y: $y, visible: $visible, selected: $selected)';
  }
}
