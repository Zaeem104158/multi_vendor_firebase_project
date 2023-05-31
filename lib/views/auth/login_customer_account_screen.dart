import 'dart:async';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/password_form_field_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/textform_field_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/email_password_validator.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class CustomerLoginScreen extends StatefulWidget {
  CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenScreenState();
}

class _CustomerLoginScreenScreenState extends State<CustomerLoginScreen> {
  late TextEditingController _emailTextEditingController =
      TextEditingController();

  late TextEditingController _passwordTextEditingController =
      TextEditingController();

  final AuthController _authController = AuthController();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _focusNode.dispose();
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
              textEditingController: _emailTextEditingController,
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
              textEditingController: _passwordTextEditingController,
            ),
            CustomSizedBox(
              height: customHeightWidth(context, height: true) / 80,
            ),
            GestureDetector(
              onTap: isLoginValidated(
                email: _emailTextEditingController.text,
                password: _passwordTextEditingController.text,
              )
                  ? () {
                      var response = _authController.loginUser(
                          _emailTextEditingController.text,
                          _passwordTextEditingController.text);
                      closeSoftKeyBoard();
                      if (response != null) {
                        Timer(Duration(seconds: 3), () {
                          navigationPush(context,
                              screenWidget: DashBoardScreen());
                        });
                      }
                    }
                  : null,
              child: Container(
                height: 50.0,
                width: customHeightWidth(context, width: true) - 40.0,
                decoration: BoxDecoration(
                    color: isLoginValidated(
                            email: _emailTextEditingController.text,
                            password: _passwordTextEditingController.text)
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
                    navigationPop(context);
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
                ),
                CustomTextComponet(
                  isClickAble: true,
                  onPressed: () {},
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
