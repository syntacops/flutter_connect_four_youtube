import 'package:flutter/material.dart';

import 'widgets/game_body.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: GameBody());
  }
}
