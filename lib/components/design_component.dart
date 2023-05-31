import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double? height;
  final double? width;

  const CustomSizedBox({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
    );
  }
}

customHeightWidth(context, {bool? height, bool? width}) {
  if (height == true) {
    return MediaQuery.of(context).size.height;
  } else if (width == true) {
    return MediaQuery.of(context).size.width;
  }
  ;
}
