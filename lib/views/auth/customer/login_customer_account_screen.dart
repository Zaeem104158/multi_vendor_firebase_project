import 'dart:async';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/password_form_field_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_formfield_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/email_password_validator.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/signup_customer_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/seller/signup_seller_account.dart';
import 'package:firebase_multi_vendor_project/views/home/customer_bottom_widget_screen.dart';
import 'package:flutter/material.dart';

class CustomerLoginScreen extends StatefulWidget {
  CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _authController.emailTextEditingController.dispose();
    _authController.passwordTextEditingController.dispose();
    _authController.focusNode.dispose();
    super.dispose();
  }

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
            //1st Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text Component
                CustomTextComponet(
                  textTitle: "Sign in to Customer's Account",
                  fontFamily: regularTextFontFamily,
                  fontSize: regularTextSize,
                  fontWeight: regularFontWeight,
                  fontHeight: null,
                  fontColor: blackColor,
                  textPadding: EdgeInsets.all(12),
                ),
                //Icon Component
                CustomIconButtonComponet(
                  icon: Icons.person,
                  iconSize: mediumIconSize,
                  iconColor: blackColor,
                  iconPadding:
                      EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 12),
                ),
              ],
            ),

            CustomTextFormFieldComponent(
              padding: EdgeInsets.all(16.0),
              isBorderEnable: true,
              formFieldLabel: "Email",
              isEmail: true,
              formFieldLabelColor: blackColor,
              formFieldLabelWeight: FontWeight.bold,
              formFieldLabelPadding: EdgeInsets.all(2),
              formFieldLabelSize: 16,
              formFieldHintColor: blackColor.withOpacity(0.4),
              formFieldHintSize: 12,
              formFieldHintWeight: FontWeight.bold,
              formFieldhHintText: "Enter your email",
              formFieldBorderRadius: 15.0,
              focusedBorderColor: Colors.green,
              focusedBorderWidth: 2,
              textEditingController: _authController.emailTextEditingController,
            ),
            CustomPasswordFormFieldComponent(
              padding: EdgeInsets.all(16.0),
              isBorderEnable: true,
              formFieldLabel: "Password",
              formFieldLabelColor: blackColor,
              formFieldLabelWeight: FontWeight.bold,
              formFieldLabelPadding: EdgeInsets.all(2),
              formFieldLabelSize: 16,
              formFieldHintColor: blackColor.withOpacity(0.4),
              formFieldHintSize: 12,
              formFieldHintWeight: FontWeight.bold,
              formFieldhHintText: "Enter your password",
              formFieldBorderRadius: 15.0,
              focusedBorderColor: Colors.green,
              focusedBorderWidth: 2.0,
              enabledBorderColor: blackColor.withOpacity(0.6),
              enabledBorderWidth: 2.0,
              textEditingController:
                  _authController.passwordTextEditingController,
            ),
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 80,
            ),
            GestureDetector(
              onTap: isLoginValidated(
                email: _authController.emailTextEditingController.text,
                password: _authController.passwordTextEditingController.text,
              )
                  ? () {
                      var response = _authController.loginCustomer(
                          _authController.emailTextEditingController.text,
                          _authController.passwordTextEditingController.text);
                      closeSoftKeyBoard();
                      if (response != null) {
                        Timer(Duration(seconds: 3), () {
                          navigationPush(context,
                              screenWidget: CustomerBottomWidgetScreen());
                        });
                      }
                    }
                  : null,
              child: Container(
                height: 50.0,
                width: customHeightWidth(context, width: true) - 40.0,
                decoration: BoxDecoration(
                    color: isLoginValidated(
                            email:
                                _authController.emailTextEditingController.text,
                            password: _authController
                                .passwordTextEditingController.text)
                        ? Colors.green
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: CustomTextComponet(
                    textTitle: "Login",
                    isClickAble: true,
                  ),
                ),
              ),
            ),
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextComponet(
                  textTitle: "Need an account?",
                  textPadding: EdgeInsets.all(16.0),
                  fontWeight: regularBoldFontWeight,
                  fontColor: blackColor,
                ),
                CustomTextComponet(
                  isClickAble: true,
                  onPressed: () {
                    navigationPush(context,
                        screenWidget: CustomerSignUpScreen());
                  },
                  textTitle: "Sign Up",
                  fontColor: Colors.grey,
                  textPadding: EdgeInsets.all(16.0),
                )
              ],
            ),
            CustomTextComponet(
              textTitle: "Or",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextComponet(
                  textTitle: "Create a seller account.",
                  textPadding: EdgeInsets.all(16.0),
                  fontWeight: regularBoldFontWeight,
                  fontColor: blackColor,
                  isClickAble: false,
                ),
                CustomTextComponet(
                  isClickAble: true,
                  onPressed: () => navigationPush(context,
                      screenWidget: SellerSignUpScreen()),
                  textTitle: "Sign Up",
                  fontColor: Colors.grey,
                  textPadding: EdgeInsets.all(16.0),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
