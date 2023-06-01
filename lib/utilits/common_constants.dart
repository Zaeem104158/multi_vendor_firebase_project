import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/signup_customer_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/customer_bottom_widget_screen.dart';
import 'package:firebase_multi_vendor_project/views/sellerdashboard/seller_bottom_widget_screen.dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Application image paths
const String appLogo_image = "assets/images/logo.png";
const String user_placeholder_image =
    'assets/images/user_placeholder_image.png';
//Shared Preference Stored Datas
const String sharedPrefCustomerUid = 'customerUid';
const String sharedPrefSellerUid = 'sellerUid';
//DashBoard Bottom Names
const String bottomHome = 'Home';
const String bottomCategory = 'Category';
const String bottomShop = 'Shop';
const String bottomCart = 'Cart';
const String bottomProfile = 'Profile';
const String bottomDashBoard = 'DashBoard';
const String bottomUpload = 'Upload';
// Firebase Collection Name
const String customers = 'customers';
const String sellers = 'sellers';
void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();

  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void loading({var value = "Please wait...", bool isHideKeyboard = true}) {
  if (isHideKeyboard) closeSoftKeyBoard();
  EasyLoading.show(status: value);
}

void dismissLoading() {
  EasyLoading.dismiss();
}

// Wrire shared preferences.
saveToSharedPreferences(String key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (value is int) {
    await prefs.setInt(key, value);
  } else if (value is double) {
    await prefs.setDouble(key, value);
  } else if (value is String) {
    await prefs.setString(key, value);
  } else if (value is bool) {
    await prefs.setBool(key, value);
  } else if (value is List<String>) {
    await prefs.setStringList(key, value);
  } else if (value == null) {
    value = 0;
    await prefs.setInt(key, value);
  } else {
    throw Exception('Unsupported data type');
  }
}

// Read shared preferences.
Future<dynamic> readFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey(key)) {
    dynamic value = prefs.get(key);

    if (value is int) {
      return value;
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return value;
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  return null;
}

startTime(context) async {
  try {
    //Reading Shared Preference customerUid data.
    dynamic customerJwt =
        await readFromSharedPreferences(sharedPrefCustomerUid);
    dynamic sellerJwt = await readFromSharedPreferences(sharedPrefSellerUid);

    // final _userController = Get.put(UserController());
    if (customerJwt != null && customerJwt != 0) {
      // _userController.getUserInfo("splash");
      navigationPush(context, screenWidget: CustomerBottomWidgetScreen());
    } else if (sellerJwt != null && sellerJwt != 0) {
      // _userController.getUserInfo("splash");
      navigationPush(context, screenWidget: SellerBottomWidgetScreen());
    } else {
      navigationPush(context, screenWidget: CustomerSignUpScreen());
    }
  } catch (e) {
    Future.delayed(const Duration(), () {
      navigationPush(context, screenWidget: CustomerSignUpScreen());
      //Get.offAll(() => const LoginScreen(), transition: sendTransition);
    });
  }
}

Future<bool> isInternetConnected(BuildContext context,
    {bool isShowAlert = false}) async {
  bool isConnected = false;

  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    }
  } catch (_) {}

  if (isShowAlert && !isConnected) {
    showMessage("Internet Connectivity Problem");
  }

  return isConnected;
}

void showMessage(String? value, {bool isToast = false, bool isInfo = false}) {
  if (isInfo) {
    EasyLoading.showInfo("$value");
  } else if (isToast) {
    EasyLoading.showSuccess("$value");
  } else {
    dismissLoading();
    EasyLoading.showError("$value",
        duration: const Duration(seconds: 5), dismissOnTap: true);
  }
}

showWarningDialog(BuildContext context) {
  Widget continueButton = CustomTextComponet(
    textTitle: "Retry",
    onPressed: () {
      navigationPop(context);
      EasyLoading.showToast("Please wait...");
      isInternetConnected(context).then((internet) {
        if (internet) {
          // Internet Present Case
          startTime(context);
        } else {
          // No-Internet Case
          showWarningDialog(context);
        }
      });
    },
  );

  Widget cancelButton = CustomTextComponet(
    textTitle: "Exit",
    onPressed: () {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    },
  );

  if (Platform.isIOS) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: CustomTextComponet(
        textTitle: "No Internet connection!",
      ),
      content: CustomTextComponet(
        textTitle: "Please Connect your device to internet first",
      ),
      actions: [cancelButton, continueButton],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } else {
    AlertDialog alert = AlertDialog(
      elevation: 2,
      title: CustomTextComponet(
        textTitle: "No Internet connection!",
      ),
      content: CustomTextComponet(
        textTitle: "Please Connect your device to internet first",
      ),
      actions: [cancelButton, continueButton],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
