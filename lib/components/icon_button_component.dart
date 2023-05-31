import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class CustomIconButtonComponet extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsets? iconPadding;
  final VoidCallback? onPressed;

  const CustomIconButtonComponet({
    required this.icon,
    this.iconPadding,
    this.iconSize = mediumIconSize,
    this.iconColor = blackColor,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: iconPadding ?? const EdgeInsets.all(0),
        child: IconButton(
          icon: Icon(icon),
          iconSize: iconSize,
          onPressed: onPressed,
        ));
  }
}
