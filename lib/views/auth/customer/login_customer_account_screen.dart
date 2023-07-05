import 'package:firebase_multi_vendor_project/components/password_form_field_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_formfield_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/email_password_validator.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/auth/forget_password/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CustomerLoginScreen extends StatelessWidget {
  CustomerLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 5,
            ),
            Padding(
              padding: REdgeInsets.all(16.0),
              child: CustomTextComponet(
                textTitle:
                    AppLocalizations.of(context)!.sign_in_to_Customers_account,
                fontFamily: regularTextFontFamily,
                fontSize: regularTextSize.sp,
                fontWeight: regularFontWeight,
                fontColor: blackColor,
                textPadding: EdgeInsets.zero,
              ),
            ),

            // Email
            CustomTextFormFieldComponent(
              isEmail: true,
              isValidate: true,
              padding: EdgeInsets.all(16.0),
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
            //Password
            CustomPasswordFormFieldComponent(
              padding: REdgeInsets.all(16.0),
              isBorderEnable: true,
              formFieldLabel: AppLocalizations.of(context)!.password,
              formFieldLabelColor: blackColor,
              formFieldLabelWeight: FontWeight.bold,
              formFieldLabelPadding: REdgeInsets.all(2),
              formFieldLabelSize: regularTextSize,
              formFieldHintColor: blackColor.withOpacity(0.4),
              formFieldHintSize: smallTextSize,
              formFieldHintWeight: FontWeight.bold,
              formFieldhHintText:
                  AppLocalizations.of(context)!.enter_your_password,
              formFieldBorderRadius: formFieldBorderRadius,
              focusedBorderColor: greenColor,
              focusedBorderWidth: formFieldBorderWidth,
              enabledBorderColor: blackColor.withOpacity(0.6),
              enabledBorderWidth: formFieldBorderWidth,
              textEditingController:
                  context.read<AuthController>().passwordTextEditingController,
              onChanged: (value) {
                context.read<AuthController>().setPasswordValue(value);
              },
            ),
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 150,
            ),
            GestureDetector(
              onTap:
                  context.read<AuthController>().isLoginSubmitButtonVisible &&
                          isLoginValidated(
                              email: context
                                  .read<AuthController>()
                                  .emailTextEditingController
                                  .text,
                              password: context
                                  .read<AuthController>()
                                  .passwordTextEditingController
                                  .text)
                      ? () {
                          context.read<AuthController>().loginCustomer(
                              context,
                              context
                                  .read<AuthController>()
                                  .emailTextEditingController
                                  .text,
                              context
                                  .read<AuthController>()
                                  .passwordTextEditingController
                                  .text);
                        }
                      : null,
              child: Container(
                height: 50.0,
                width: customHeightWidth(context, width: true) - 40.0,
                decoration: BoxDecoration(
                    color: context
                                .read<AuthController>()
                                .isLoginSubmitButtonVisible &&
                            isLoginValidated(
                                email: context
                                    .read<AuthController>()
                                    .emailTextEditingController
                                    .text,
                                password: context
                                    .read<AuthController>()
                                    .passwordTextEditingController
                                    .text)
                        ? Colors.green
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: CustomTextComponet(
                    textTitle: AppLocalizations.of(context)!.login,
                    isClickAble: true,
                  ),
                ),
              ),
            ),
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 80,
            ),
            Padding(
              padding: REdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextComponet(
                    textTitle: AppLocalizations.of(context)!.forget_passwowrd,
                    fontWeight: regularBoldFontWeight,
                    fontColor: blackColor,
                    fontSize: smallTextSize.sp,
                  ),
                  CustomTextComponet(
                    isClickAble: true,
                    onPressed: () {
                      navigationPush(context,
                          screenWidget: ForgetPasswordScreen(
                            user: "customer",
                          ));
                    },
                    textTitle: AppLocalizations.of(context)!.click_here,
                    fontSize: smallTextSize.sp,
                    fontColor: Colors.grey,
                    textPadding: EdgeInsets.all(16.0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
