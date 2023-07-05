import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/components/text_formfield_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/email_password_validator.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  String? user;
  ForgetPasswordScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextComponet(
              textTitle: AppLocalizations.of(context)!
                  .enter_your_email_for_reset_your_password,
              isClickAble: false,
              maxLine: 2,
              textPadding: EdgeInsets.all(4.0),
            ),
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 30,
            ),
            // Email
            CustomTextFormFieldComponent(
              isEmail: true,
              isValidate: true,
              padding: EdgeInsets.all(4.0),
              isBorderEnable: true,
              formFieldLabel: AppLocalizations.of(context)!.email,
              formFieldLabelColor: blackColor,
              formFieldLabelWeight: FontWeight.bold,
              formFieldLabelPadding: EdgeInsets.all(2),
              formFieldLabelSize: regularTextSize,
              formFieldHintColor: blackColor.withOpacity(0.4),
              formFieldHintSize: smallTextSize,
              formFieldHintWeight: FontWeight.bold,
              formFieldhHintText:
                  AppLocalizations.of(context)!.enter_your_email,
              formFieldBorderRadius: formFieldBorderRadius,
              focusedBorderColor: greenColor,
              focusedBorderWidth: formFieldBorderWidth,
              enabledBorderColor: blackColor.withOpacity(0.6),
              enabledBorderWidth: formFieldBorderWidth,
              textEditingController:
                  context.read<AuthController>().emailTextEditingController,
              onChanged: (value) {
                context.read<AuthController>().setEmailValue(value);
              },
            ),
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 30,
            ),
            GestureDetector(
              onTap: context
                          .watch<AuthController>()
                          .isForgetPasswordSubmitButtonVisible &&
                      isForgetPasswordValidated(
                        email: context
                            .read<AuthController>()
                            .emailTextEditingController
                            .text,
                      )
                  ? () {
                      context.read<AuthController>().resetPassword(
                            context,
                            user,
                            context
                                .read<AuthController>()
                                .emailTextEditingController
                                .text,
                          );
                    }
                  : null,
              child: Container(
                height: 50.0,
                width: customHeightWidth(context, width: true) - 40.0,
                decoration: BoxDecoration(
                    color: context
                                .watch<AuthController>()
                                .isForgetPasswordSubmitButtonVisible &&
                            isForgetPasswordValidated(
                              email: context
                                  .read<AuthController>()
                                  .emailTextEditingController
                                  .text,
                            )
                        ? Colors.green
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: CustomTextComponet(
                    textTitle: AppLocalizations.of(context)!.submit,
                    isClickAble: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
