import 'package:flutter/material.dart';

class MyGhost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset("lib/img/ghost.png"),
    );
  }
}
