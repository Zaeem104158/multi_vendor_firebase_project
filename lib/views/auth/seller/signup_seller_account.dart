import 'dart:async';
import 'dart:io';
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
import 'package:firebase_multi_vendor_project/views/auth/seller/login_seller_account.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/signup_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerSignUpScreen extends StatefulWidget {
  SellerSignUpScreen({super.key});

  @override
  State<SellerSignUpScreen> createState() => _SellerSignUpScreenState();
}

class _SellerSignUpScreenState extends State<SellerSignUpScreen> {
  late TextEditingController _fullNameTextEditingController =
      TextEditingController();

  late TextEditingController _emailTextEditingController =
      TextEditingController();

  late TextEditingController _passwordTextEditingController =
      TextEditingController();

  final AuthController _authController = AuthController();
  final FocusNode _focusNode = FocusNode();
  File? _image;

  Future _getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _focusNode.unfocus();
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
              height: customHeightWidth(context, height: true) / 160,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text Component
                CustomTextComponet(
                  textTitle: "Create Seller's Account",
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
                  iconPadding: EdgeInsets.all(12),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: blackColor.withOpacity(0.4),
                    radius: 60.0,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
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
                            _getImage(ImageSource.camera);
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
                            _getImage(ImageSource.gallery);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            CustomTextFormFieldComponent(
              padding: EdgeInsets.all(16.0),
              isBorderEnable: true,
              formFieldLabel: "Full Name",
              isEmail: false,
              formFieldLabelColor: blackColor,
              formFieldLabelWeight: FontWeight.bold,
              formFieldLabelPadding: EdgeInsets.all(16.0),
              formFieldLabelSize: 16,
              formFieldHintColor: blackColor.withOpacity(0.4),
              formFieldHintSize: 12,
              formFieldHintWeight: FontWeight.bold,
              formFieldhHintText: "Enter your full name",
              formFieldBorderRadius: 15.0,
              focusedBorderColor: Colors.green,
              focusedBorderWidth: 2,
              textEditingController: _fullNameTextEditingController,
              isValidate: false,
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
              height: customHeightWidth(context, height: true) / 150,
            ),
            GestureDetector(
              onTap: isSignUpValidated(
                      fullName: _fullNameTextEditingController.text,
                      email: _emailTextEditingController.text,
                      password: _passwordTextEditingController.text,
                      imageFile: _image)
                  ? () {
                      var response = _authController.signUpSeller(
                          _fullNameTextEditingController.text,
                          _emailTextEditingController.text,
                          _passwordTextEditingController.text,
                          _image);
                      closeSoftKeyBoard();
                      if (response != null) {
                        Timer(Duration(seconds: 3), () {
                          navigationPush(context,
                              screenWidget: SellerLoginScreen());
                        });
                      }
                    }
                  : null,
              child: Container(
                height: 50.0,
                width: customHeightWidth(context, width: true) - 40.0,
                decoration: BoxDecoration(
                    color: isSignUpValidated(
                            fullName: _fullNameTextEditingController.text,
                            email: _emailTextEditingController.text,
                            password: _passwordTextEditingController.text,
                            imageFile: _image)
                        ? Colors.green
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: CustomTextComponet(
                    textTitle: "Submit",
                    isClickAble: true,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextComponet(
                  textTitle: "Already have an account?",
                  textPadding: EdgeInsets.all(16.0),
                  fontWeight: regularBoldFontWeight,
                  fontColor: blackColor,
                ),
                CustomTextComponet(
                  isClickAble: true,
                  onPressed: () {
                    navigationPush(context, screenWidget: SellerLoginScreen());
                  },
                  textTitle: "Login",
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
                GestureDetector(
                  onTap: () => navigationPush(context,
                      screenWidget: CustomerSignUpScreen()),
                  child: CustomTextComponet(
                    textTitle: "Create a customer account.",
                    textPadding: EdgeInsets.all(16.0),
                    fontWeight: regularBoldFontWeight,
                    fontColor: blackColor,
                    isClickAble: true,
                  ),
                ),
                CustomTextComponet(
                  isClickAble: true,
                  onPressed: () => navigationPush(context,
                      screenWidget: CustomerSignUpScreen()),
                  textTitle: "Sign Up",
                  fontColor: Colors.grey,
                  textPadding: EdgeInsets.all(8.0),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
