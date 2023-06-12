import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class CustomTextComponet extends StatelessWidget {
  final String? textTitle;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? fontHeight;
  final Color? fontColor;
  final TextOverflow? textOverflow;
  final EdgeInsets? textPadding;
  final TextDecoration? textDecoration;
  final Color? lineThroughColor;
  final int? maxLine;
  final bool isClickAble;
  final bool isCenterText;
  final VoidCallback? onPressed;

  const CustomTextComponet(
      {this.textTitle,
      this.fontFamily = regularTextFontFamily,
      this.fontSize = regularTextSize,
      this.fontWeight = regularFontWeight,
      this.fontHeight = null,
      this.fontColor = blackColor,
      this.textOverflow = TextOverflow.ellipsis,
      this.textDecoration = TextDecoration.none,
      this.lineThroughColor = blackColor,
      this.textPadding,
      this.maxLine,
      this.isClickAble = false,
      this.onPressed,
      this.isCenterText = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: textPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: isClickAble == true ? onPressed : () {},
        child: isCenterText
            ? Center(
                child: Text(
                  textTitle ?? "",
                  maxLines: maxLine ?? 1,
                  style: TextStyle(
                      decoration: textDecoration,
                      decorationColor: lineThroughColor,
                      fontFamily: regularTextFontFamily,
                      fontSize: fontSize,
                      color: fontColor,
                      fontWeight: fontWeight,
                      height: fontHeight,
                      overflow: textOverflow),
                ),
              )
            : Text(
                textTitle ?? "",
                maxLines: maxLine ?? 1,
                style: TextStyle(
                    fontFamily: regularTextFontFamily,
                    decoration: textDecoration,
                    decorationColor: lineThroughColor,
                    fontSize: fontSize,
                    color: fontColor,
                    fontWeight: fontWeight,
                    height: fontHeight,
                    overflow: textOverflow),
              ),
      ),
    );
  }
}
