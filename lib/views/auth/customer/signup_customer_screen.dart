import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/password_form_field_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_formfield_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/email_password_validator.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/login_customer_account_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/seller/login_seller_account_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/seller/signup_seller_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CustomerSignUpScreen extends StatelessWidget {
  CustomerSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 160,
            ),
            Padding(
              padding: REdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Text Component
                  CustomTextComponet(
                    textTitle:
                        AppLocalizations.of(context)!.create_customers_account,
                    fontFamily: regularTextFontFamily,
                    fontSize: regularTextSize.sp,
                    fontWeight: regularFontWeight,
                    fontColor: blackColor,
                    textPadding: EdgeInsets.zero,
                  ),
                  //Icon Component
                  CustomIconButtonComponet(
                    icon: Icons.person,
                    iconSize: mediumIconSize.sp,
                    iconColor: blackColor,
                    iconPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: blackColor.withOpacity(0.4),
                    radius: 60.0,
                    backgroundImage:
                        context.read<AuthController>().image != null
                            ? FileImage(context.read<AuthController>().image!)
                            : null,
                  ),
                  CustomSizedBox(
                    width: customHeightWidth(context, width: true) * 0.06,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: blackColor.withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0))),
                        child: CustomIconButtonComponet(
                          icon: Icons.camera_alt,
                          onPressed: () {
                            context.read<AuthController>().getImage(
                                context, ImageSource.camera,
                                isMultipleImages: false);
                          },
                        ),
                      ),
                      CustomSizedBox(
                        height: customHeightWidth(context, height: true) / 100,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: blackColor.withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0))),
                        child: CustomIconButtonComponet(
                          icon: Icons.photo_album,
                          onPressed: () {
                            context.read<AuthController>().getImage(
                                context, ImageSource.gallery,
                                isMultipleImages: false);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //Full Name
            CustomTextFormFieldComponent(
              padding: EdgeInsets.all(16.0),
              isBorderEnable: true,
              formFieldLabel: AppLocalizations.of(context)!.full_name,
              isEmail: false,
              isValidate: true,
              formFieldLabelColor: blackColor,
              formFieldLabelWeight: FontWeight.bold,
              formFieldLabelPadding: REdgeInsets.all(16.0),
              formFieldLabelSize: regularTextSize,
              formFieldHintColor: blackColor.withOpacity(0.4),
              formFieldHintSize: smallTextSize,
              formFieldHintWeight: FontWeight.bold,
              formFieldhHintText:
                  AppLocalizations.of(context)!.enter_your_full_name,
              formFieldBorderRadius: formFieldBorderRadius,
              focusedBorderColor: greenColor,
              focusedBorderWidth: formFieldBorderWidth,
              textEditingController:
                  context.read<AuthController>().fullNameTextEditingController,
              onChanged: (value) {
                context.read<AuthController>().setFullNameValue(value);
              },
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
                  context.watch<AuthController>().isSignUpSubmitButtonVisible &&
                          isSignUpValidated(
                              fullName: context
                                  .read<AuthController>()
                                  .fullNameTextEditingController
                                  .text,
                              email: context
                                  .read<AuthController>()
                                  .emailTextEditingController
                                  .text,
                              password: context
                                  .read<AuthController>()
                                  .passwordTextEditingController
                                  .text,
                              imageFile: context.read<AuthController>().image)
                      ? () {
                          context.read<AuthController>().signUpCustomer(
                              context,
                              context
                                  .read<AuthController>()
                                  .fullNameTextEditingController
                                  .text,
                              context
                                  .read<AuthController>()
                                  .emailTextEditingController
                                  .text,
                              context
                                  .read<AuthController>()
                                  .passwordTextEditingController
                                  .text,
                              context.read<AuthController>().image);
                        }
                      : null,
              child: Container(
                height: 50.0,
                width: customHeightWidth(context, width: true) - 40.0,
                decoration: BoxDecoration(
                    color: context
                                .watch<AuthController>()
                                .isSignUpSubmitButtonVisible &&
                            isSignUpValidated(
                                fullName: context
                                    .read<AuthController>()
                                    .fullNameTextEditingController
                                    .text,
                                email: context
                                    .read<AuthController>()
                                    .emailTextEditingController
                                    .text,
                                password: context
                                    .read<AuthController>()
                                    .passwordTextEditingController
                                    .text,
                                imageFile: context.read<AuthController>().image)
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
            Padding(
              padding: REdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextComponet(
                    textTitle: AppLocalizations.of(context)!
                        .already_have_a_customers_account,
                    textPadding: REdgeInsets.all(0.0),
                    fontWeight: regularBoldFontWeight,
                    fontColor: blackColor,
                    fontSize: smallTextSize.sp,
                    isClickAble: false,
                  ),
                  CustomTextComponet(
                    isClickAble: true,
                    onPressed: () {
                      navigationPush(context,
                          screenWidget: CustomerLoginScreen());
                    },
                    textTitle: AppLocalizations.of(context)!.login,
                    fontColor: greyColor,
                    fontSize: smallTextSize.sp,
                    textPadding: REdgeInsets.all(0.0),
                  )
                ],
              ),
            ),
            CustomTextComponet(
              textTitle: AppLocalizations.of(context)!.or,
              fontSize: smallTextSize,
            ),
            Padding(
              padding: REdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextComponet(
                    textTitle:
                        AppLocalizations.of(context)!.create_sellers_account,
                    textPadding: REdgeInsets.all(0.0),
                    fontWeight: regularBoldFontWeight,
                    fontColor: blackColor,
                    fontSize: smallTextSize.sp,
                    isClickAble: false,
                  ),
                  CustomTextComponet(
                    isClickAble: true,
                    onPressed: () => navigationPush(context,
                        removeUntil: false, screenWidget: SellerSignUpScreen()),
                    textTitle: AppLocalizations.of(context)!.sign_up,
                    fontColor: greyColor,
                    fontSize: smallTextSize.sp,
                    textPadding: REdgeInsets.all(0.0),
                  )
                ],
              ),
            ),
            CustomTextComponet(
              textTitle: AppLocalizations.of(context)!.or,
              fontSize: smallTextSize,
            ),
            Padding(
              padding: REdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextComponet(
                    textTitle: AppLocalizations.of(context)!
                        .already_have_a_sellers_account,
                    textPadding: REdgeInsets.all(0.0),
                    fontWeight: regularBoldFontWeight,
                    fontColor: blackColor,
                    fontSize: smallTextSize.sp,
                    isClickAble: false,
                  ),
                  CustomTextComponet(
                    isClickAble: true,
                    onPressed: () {
                      navigationPush(context,
                          screenWidget: SellerLoginScreen());
                    },
                    textTitle: AppLocalizations.of(context)!.login,
                    fontColor: greyColor,
                    fontSize: smallTextSize.sp,
                    textPadding: REdgeInsets.all(0.0),
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
