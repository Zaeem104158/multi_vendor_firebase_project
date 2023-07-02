import 'dart:async';
import 'dart:developer';

import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/login_customer_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void didChangeDependencies() async {
    final provider = Provider.of<AuthController>(context, listen: false);
    String email = await readFromSharedPreferences('currentEmail') ?? '';
    String password = await readFromSharedPreferences('currentPassword') ?? '';

    Timer.periodic(Duration(minutes: 5), (timer) async {
      log("Here run bug");
      log("$email $password");
      bool isVerified = await provider.getEmailVerified(context,
          email: email, password: password);
      if (isVerified) {
        provider.clearAll();
        navigationPush(context,
            removeUntil: false, screenWidget: CustomerLoginScreen());
        timer.cancel();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomTextComponet(
          textTitle: AppLocalizations.of(context)!
              .verification_code_has_sent_to_the_mail,
          isClickAble: false,
          isCenterText: true,
        ),
      ),
    );
  }
}
















// Center(
//                       child: Container(
//                         height: 100.0,
//                         width: customHeightWidth(context, width: true) - 40.0,
//                         decoration: BoxDecoration(
//                             color: blueGreyColor,
//                             borderRadius: BorderRadius.circular(30.0)),
//                         child: Center(
//                           child: CustomTextComponet(
//                             textTitle: AppLocalizations.of(context)!.submit,
//                             isCenterText: true,
//                             maxLine: 2,
//                             isClickAble: true,
//                             fontWeight: regularBoldFontWeight,
//                             textPadding: REdgeInsets.all(8),
//                             onPressed: () async {
//                               bool check = await context
//                                   .read<AuthController>()
//                                   .setEmailVerified();
//                               check == true
//                                   ? navigationPush(context,
//                                       removeUntil: false,
//                                       screenWidget: CustomerLoginScreen())
//                                   : showSnack(context, "asdad");
//                             },
//                           ),
//                         ),
//                       ),
//                     );