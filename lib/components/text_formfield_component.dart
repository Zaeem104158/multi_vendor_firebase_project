import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/email_password_validator.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldComponent extends StatelessWidget {
  final EdgeInsets? padding;
  final String? formFieldLabel;
  final String? formFieldhHintText;
  final double? formFieldBorderRadius;
  final Color? formFieldLabelColor;
  final double? formFieldLabelSize;
  final FontWeight? formFieldLabelWeight;
  final double? formFieldLabelHeight;
  final EdgeInsets? formFieldLabelPadding;
  final Color? formFieldHintColor;
  final double? formFieldHintSize;
  final FontWeight? formFieldHintWeight;
  final double? formFieldHintHeight;
  final bool isBorderEnable;
  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final double? enabledBorderWidth;
  final Color? enabledBorderColor;
  final TextEditingController? textEditingController;
  final bool isValidate;
  final int? maxLenght;
  final int? maxLine;
  final TextInputType? keyboardType;
  final bool isEmail;
  final bool isNumber;
  final bool isLable;
  final TextInputAction textInputAction;
  final double? inputFontSize;
  final Color? inputFontColor;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry contentPadding;

  CustomTextFormFieldComponent(
      {this.padding = const EdgeInsets.all(8),
      this.formFieldLabel,
      this.formFieldhHintText,
      this.formFieldBorderRadius,
      this.formFieldLabelColor = blackColor,
      this.formFieldLabelSize = smallTextSize,
      this.formFieldLabelWeight = regularFontWeight,
      this.formFieldLabelHeight = null,
      this.formFieldLabelPadding = const EdgeInsets.all(4),
      this.formFieldHintColor = blackColor,
      this.formFieldHintSize = smallerTextSize,
      this.formFieldHintWeight = regularFontWeight,
      this.formFieldHintHeight = null,
      this.isBorderEnable = false,
      this.isLable = true,
      this.focusedBorderColor,
      this.focusedBorderWidth,
      this.enabledBorderWidth,
      this.enabledBorderColor,
      this.textEditingController,
      this.maxLenght,
      this.maxLine,
      this.isValidate = true,
      this.isEmail = false,
      this.onChanged,
      this.isNumber = false,
      this.textInputAction = TextInputAction.next,
      this.inputFontSize = regularTextSize,
      this.inputFontColor = blackColor,
      this.contentPadding = const EdgeInsets.all(0),
      this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          style: TextStyle(fontSize: inputFontSize, color: inputFontColor),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLength: maxLenght,
          maxLines: maxLine,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: isBorderEnable == true
                ? OutlineInputBorder(
                    borderRadius: isBorderEnable == true
                        ? BorderRadius.circular(formFieldBorderRadius ?? 0.0)
                        : BorderRadius.circular(0.0),
                    borderSide: BorderSide(
                        color: enabledBorderColor ?? blackColor,
                        width: enabledBorderWidth ?? 1.0),
                  )
                : null,
            focusedBorder: isBorderEnable == true
                ? OutlineInputBorder(
                    borderRadius: isBorderEnable == true
                        ? BorderRadius.circular(formFieldBorderRadius ?? 0.0)
                        : BorderRadius.circular(0.0),
                    borderSide: BorderSide(
                        color: focusedBorderColor ?? blackColor,
                        width: focusedBorderWidth ?? 1.0),
                  )
                : null,
            label: isLable
                ? CustomTextComponet(
                    textTitle: formFieldLabel,
                    fontColor: formFieldLabelColor,
                    fontSize: formFieldLabelSize,
                    fontWeight: formFieldLabelWeight,
                    fontHeight: formFieldLabelHeight,
                    textPadding: formFieldLabelPadding)
                : null,
            hintText: formFieldhHintText,
            hintStyle: TextStyle(
              color: formFieldHintColor,
              fontFamily: regularTextFontFamily,
              fontSize: formFieldHintSize,
              fontWeight: formFieldHintWeight,
              height: formFieldHintHeight,
              overflow: TextOverflow.ellipsis,
            ),
            // contentPadding: contentPadding,
            border: isBorderEnable == true
                ? OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(formFieldBorderRadius ?? 0.0))
                : UnderlineInputBorder(),
          ),
          controller: textEditingController,
          validator: isValidate && isEmail
              ? (value) {
                  if (value == null) {
                    return "Empty input.";
                  } else if (value.isEmpty) {
                    return "Empty input.";
                  } else if (!regEmailExp.hasMatch(value)) {
                    return "Invalide email.";
                  } else {
                    return null;
                  }
                }
              : isValidate && !isEmail && !isNumber
                  ? (value) {
                      if (value == null) {
                        return "Empty input.";
                      } else if (value.isEmpty) {
                        return "Empty input.";
                      } else {
                        return null;
                      }
                    }
                  : isValidate && !isEmail && isNumber
                      ? (value) {
                          if (value == null) {
                            return "Empty input.";
                          } else if (value.isEmpty) {
                            return "Empty input.";
                          } else {
                            return null;
                          }
                        }
                      : null,
        ),
      ),
    );
  }
}
