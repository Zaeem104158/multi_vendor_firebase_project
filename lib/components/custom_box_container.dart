import 'package:flutter/material.dart';

class CustomBoxContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadius? borderRadius;
  final BoxDecoration? decoration;
  final Widget? child;
  final EdgeInsets? padding;
  CustomBoxContainer({
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.child,
    this.decoration,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(8.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}
