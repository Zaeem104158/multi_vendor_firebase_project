import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/email_password_validator.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomPasswordFormFieldComponent extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: true);

    return Padding(
      padding: padding ?? const EdgeInsets.all(8),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          decoration: InputDecoration(
              label: CustomTextComponet(
                  textTitle: formFieldLabel,
                  fontColor: formFieldLabelColor,
                  fontSize: formFieldLabelSize,
                  fontWeight: formFieldLabelWeight,
                  fontHeight: formFieldLabelHeight,
                  textPadding: formFieldLabelPadding),
              hintText: formFieldhHintText,
              hintStyle: TextStyle(
                color: formFieldHintColor,
                fontFamily: regularTextFontFamily,
                fontSize: formFieldHintSize,
                fontWeight: formFieldHintWeight,
                height: formFieldHintHeight,
                // overflow: TextOverflow.visible,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: isBorderEnable == true
                    ? BorderRadius.circular(formFieldBorderRadius ?? 0.0)
                    : BorderRadius.circular(0.0),
                borderSide: BorderSide(
                    color: enabledBorderColor ?? blackColor,
                    width: enabledBorderWidth ?? 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: isBorderEnable == true
                    ? BorderRadius.circular(formFieldBorderRadius ?? 0.0)
                    : BorderRadius.circular(0.0),
                borderSide: BorderSide(
                    color: focusedBorderColor ?? blackColor,
                    width: focusedBorderWidth ?? 1.0),
              ),
              border: isBorderEnable == true
                  ? OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(formFieldBorderRadius ?? 0.0))
                  : InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: () {
                  uiProvider.updateIsVisibleValue();
                },
                child: CustomIconButtonComponet(
                    icon: uiProvider.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
              )),
          obscureText: !uiProvider.isPasswordVisible,
          obscuringCharacter: '*',
          controller: textEditingController,
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
