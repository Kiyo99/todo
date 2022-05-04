import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BoxComponent extends HookWidget {
  const BoxComponent({Key? key, required this.boxHeight, required this.boxWidth, required this.child, required this.color}) : super(key: key);

  final double boxHeight;
  final double boxWidth;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxHeight,
      width: boxWidth,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: child,
    );
  }
}
