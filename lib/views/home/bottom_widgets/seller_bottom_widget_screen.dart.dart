import 'dart:io';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/views/store/store_screen.dart';
import 'package:firebase_multi_vendor_project/views/upload_product/products_upload_screen.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/category/category_screen.dart';
import 'package:firebase_multi_vendor_project/views/dashboard/seller_dashboard_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class SellerBottomWidgetScreen extends StatefulWidget {
  SellerBottomWidgetScreen({super.key});

  @override
  State<SellerBottomWidgetScreen> createState() =>
      _SellerBottomWidgetScreenState();
}

class _SellerBottomWidgetScreenState extends State<SellerBottomWidgetScreen> {
  final AuthController authController = AuthController();
  int selectedIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    SellerDashBoardScreen(),
    ProductUploadScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to exit?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            //backgroundColor: blueGreyColor.shade600,
            selectedItemColor: blackColor,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 16.0,
            unselectedFontSize: 16.0,
            type: BottomNavigationBarType.shifting,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: bottomHome),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  label: bottomCategory),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shop,
                  ),
                  label: bottomShop),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dashboard,
                  ),
                  label: bottomDashBoard),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.upload_file,
                  ),
                  label: bottomUpload)
            ]),
        body: screens[selectedIndex],
      ),
    );
  }
}
