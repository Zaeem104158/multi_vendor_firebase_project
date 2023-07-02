import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    this.iconColor,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: iconPadding ?? const EdgeInsets.all(0),
        child: IconButton(
          constraints: BoxConstraints(
              maxWidth: 30.sp,
              maxHeight: 30.sp,
              minHeight: 10.sp,
              minWidth: 10.sp),
          icon: Icon(icon, color: iconColor),
          iconSize: iconSize,
          onPressed: onPressed,
        ));
  }
}
