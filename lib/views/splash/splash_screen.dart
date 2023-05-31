import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime(context);
    isInternetConnected(context).then((internet) {
      if (internet) {
        // Internet Present Case
        startTime(context);
      } else {
        // No-Internet Case
        showWarningDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Image.asset(AppLogo),
    );
  }
}
