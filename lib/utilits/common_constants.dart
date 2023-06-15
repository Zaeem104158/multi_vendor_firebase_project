import 'dart:ffi';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/signup_customer_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/bottom_widgets/customer_bottom_widget_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/bottom_widgets/seller_bottom_widget_screen.dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
// Firebase Collection Name keys
//customer keys
const String customersDirectory = 'customers';
const String customersCollectionFieldCid = 'cid';
const String customersCollectionFieldFullName = 'fullName';
const String customersCollectionFieldEmail = 'email';
const String customersCollectionFieldImageFile = 'imageFile';
const String customersCollectionFieldAddress = 'address';
const String customersCollectionFieldPhoneNumber = 'phoneNumber';
//Seller keys
const String sellersDirectory = 'sellers';
const String sellerCollectionFieldSid = 'sid';
const String sellerCollectionFieldIsProductNew = 'isProductNew';
const String sellerCollectionFieldFullName = 'fullName';
const String sellerCollectionFieldEmail = 'email';
const String sellerCollectionFieldImageFile = 'imageFile';
const String sellerCollectionFieldAddress = 'address';
const String sellerCollectionFieldPhoneNumber = 'phoneNumber';
// Seller upload product keys
const String productImageDirectory = 'productImages';
const String productsDataDirectory = 'productsData';
const String productCollectionFieldProductId = 'productId';
const String productCollectionFieldMainCategory = 'mainCategory';
const String productCollectionFieldSubCategory = 'subCategory';
const String productCollectionFieldProductPrice = 'productPrice';
const String productCollectionFieldProductName = 'productName';
const String productCollectionFieldProductDescription = 'productDescription';
const String productCollectionFieldProductInStock = 'productInstock';
const String productCollectionFieldProductDiscount = 'productDiscount';
const String productCollectionFieldProductImageFile = 'productImageFile';

//Image Directory
const String customerProfileImageDirectory = 'profileImages/customers';
const String sellerProfileImageDirectory = 'profileImages/sellers';

// Theme
const String themeModeKey = 'themeModeKey';
//Close keyboard
void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();

  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

// Loading
void loading({var value = "Please wait...", bool isHideKeyboard = true}) {
  if (isHideKeyboard) closeSoftKeyBoard();
  EasyLoading.show(status: value);
}

// Close Loading
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

// Start Time check weather the user is already log in or not.
startTime(context) async {
  try {
    //Reading Shared Preference customerUid data.
    dynamic customerJwt =
        await readFromSharedPreferences(sharedPrefCustomerUid);
    dynamic sellerJwt = await readFromSharedPreferences(sharedPrefSellerUid);

    if (customerJwt != null && customerJwt != 0) {
      navigationPush(context, screenWidget: CustomerBottomWidgetScreen());
    } else if (sellerJwt != null && sellerJwt != 0) {
      navigationPush(context, screenWidget: SellerBottomWidgetScreen());
    } else {
      navigationPush(context, screenWidget: CustomerSignUpScreen());
    }
  } catch (e) {
    Future.delayed(const Duration(), () {
      navigationPush(context, screenWidget: CustomerSignUpScreen());
    });
  }
}

//check internet connection.
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

// Show toaster messagge
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

// Show warning Dialog
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

void sendWhatsAppMessage(String phoneNumber, String message) async {
  String url =
      "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";

  try {
    await launchUrl(Uri.parse(url.toString()));
  } catch (e) {
    throw 'Could not launch $e';
  }
}

void showSnack(context, String? content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: cyanColor.withGreen(150),
    content: CustomTextComponet(
      textTitle: content ?? "",
      fontColor: whiteColor,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    duration: Duration(seconds: 2),
  ));
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
