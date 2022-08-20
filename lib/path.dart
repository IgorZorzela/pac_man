import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  //const MyPixel({Key? key}) : super(key: key);

  final innerColor;
  final outerColor;
  final child;

  MyPath({this.innerColor, this.outerColor, this.child, Color? color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(15),
          color: outerColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: innerColor,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
