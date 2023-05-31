import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? thickness;
  final double? height;
  final double? width;
  final Color? color;
  final String? text;
  final bool isCenter;
  final bool onlyDivider;
  final bool withTextDivider;
  final MainAxisAlignment? mainAxisAlignment;
  CustomDivider(
      {this.thickness,
      this.height,
      this.color,
      this.text,
      this.isCenter = false,
      this.mainAxisAlignment,
      this.onlyDivider = false,
      this.withTextDivider = false,
      this.width});
  @override
  Widget build(BuildContext context) {
    return isCenter && withTextDivider && !onlyDivider
        ? Center(
            child: Row(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
              children: [
                SizedBox(
                  height:
                      height ?? customHeightWidth(context, height: true) / 400,
                  width: width ?? customHeightWidth(context, width: true) / 5,
                  child: Divider(
                    thickness: thickness,
                    color: color,
                  ),
                ),
                CustomTextComponet(
                  textTitle: text,
                  textPadding: EdgeInsets.all(2),
                ),
                SizedBox(
                  height: customHeightWidth(context, height: true) / 400,
                  width: customHeightWidth(context, width: true) / 5,
                  child: Divider(
                    thickness: thickness,
                    color: color,
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            height: height ?? customHeightWidth(context, height: true) / 400,
            width: width ?? customHeightWidth(context, width: true) / 5,
            child: Divider(
              thickness: thickness,
              color: color,
            ),
          );
  }
}
