import 'package:flutter/material.dart';
import 'package:flutter_connect_four_youtube/controllers/game_controller.dart';
import 'package:get/get.dart';

import 'cell.dart';

class BoardColumn extends StatelessWidget {
  final GameController gameController = Get.find<GameController>();
  final List<int> columnOfPlayerChips;

  BoardColumn({
    Key key,
    @required this.columnOfPlayerChips,
  }) : super(key: key);

  List<Cell> _buildBoardColumn() {
    return columnOfPlayerChips.map((number) => Cell()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _buildBoardColumn(),
    );
  }
}
