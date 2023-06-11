import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? thickness;
  final double? height;
  final double? width;
  final Color? color;
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final EdgeInsets? textPadding;
  final TextDecoration? textDecoration;
  final bool isClickAble;
  final bool isCenterText;
  final bool isCenter;
  final bool onlyDivider;
  final bool withTextDivider;

  final MainAxisAlignment? mainAxisAlignment;
  CustomDivider(
      {this.thickness,
      this.height,
      this.color,
      this.text,
      this.fontColor,
      this.fontWeight,
      this.fontSize,
      this.isCenter = false,
      this.isClickAble = false,
      this.isCenterText = true,
      this.textPadding,
      this.textDecoration,
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
                  textPadding: textPadding,
                  fontColor: fontColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  isCenterText: true,
                  isClickAble: false,
                  textDecoration: textDecoration,
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
