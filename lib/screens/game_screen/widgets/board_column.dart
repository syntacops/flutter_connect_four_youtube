import 'package:flutter/material.dart';

import 'cell.dart';

class BoardColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Cell(),
        Cell(),
        Cell(),
        Cell(),
        Cell(),
        Cell(),
      ],
    );
  }
}
