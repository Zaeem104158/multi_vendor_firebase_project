import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/email_password_validator.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class CustomPasswordFormFieldComponent extends StatefulWidget {
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
  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final double? enabledBorderWidth;
  final Color? enabledBorderColor;
  final bool isBorderEnable;
  final TextEditingController? textEditingController;

  const CustomPasswordFormFieldComponent({
    this.padding = const EdgeInsets.all(8),
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
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.enabledBorderWidth,
    this.enabledBorderColor,
    this.isBorderEnable = false,
    this.textEditingController,
  });

  @override
  State<CustomPasswordFormFieldComponent> createState() =>
      _CustomPasswordFormFieldComponentState();
}

class _CustomPasswordFormFieldComponentState
    extends State<CustomPasswordFormFieldComponent> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          decoration: InputDecoration(
              label: CustomTextComponet(
                  textTitle: widget.formFieldLabel,
                  fontColor: widget.formFieldLabelColor,
                  fontSize: widget.formFieldLabelSize,
                  fontWeight: widget.formFieldLabelWeight,
                  fontHeight: widget.formFieldLabelHeight,
                  textPadding: widget.formFieldLabelPadding),
              hintText: widget.formFieldhHintText,
              hintStyle: TextStyle(
                color: widget.formFieldHintColor,
                fontFamily: regularTextFontFamily,
                fontSize: widget.formFieldHintSize,
                fontWeight: widget.formFieldHintWeight,
                height: widget.formFieldHintHeight,
                // overflow: TextOverflow.visible,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: widget.isBorderEnable == true
                    ? BorderRadius.circular(widget.formFieldBorderRadius ?? 0.0)
                    : BorderRadius.circular(0.0),
                borderSide: BorderSide(
                    color: widget.enabledBorderColor ?? blackColor,
                    width: widget.enabledBorderWidth ?? 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: widget.isBorderEnable == true
                    ? BorderRadius.circular(widget.formFieldBorderRadius ?? 0.0)
                    : BorderRadius.circular(0.0),
                borderSide: BorderSide(
                    color: widget.focusedBorderColor ?? blackColor,
                    width: widget.focusedBorderWidth ?? 1.0),
              ),
              border: widget.isBorderEnable == true
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          widget.formFieldBorderRadius ?? 0.0))
                  : InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: () => setState(() {
                  isPasswordVisible = !isPasswordVisible;
                }),
                child: CustomIconButtonComponet(
                    icon: !isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
              )),

          //controller: ,
          obscureText: isPasswordVisible,
          obscuringCharacter: '*',
          controller: widget.textEditingController,
          validator: (value) {
            if (value == null) {
              return "Empty input.";
            } else if (value.isEmpty) {
              return "Empty input.";
            } else if (!regPassExp.hasMatch(value)) {
              return "At least One Upper Case,\nOne Lower Case,\nOne Number and\n6 digits lenght";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
