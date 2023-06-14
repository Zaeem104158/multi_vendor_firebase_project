import 'dart:io';

import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/cart/cart_screen.dart';
import 'package:firebase_multi_vendor_project/views/category/category_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/home_screen.dart';
import 'package:firebase_multi_vendor_project/views/profie/customer_profile_screen.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_multi_vendor_project/views/store/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerBottomWidgetScreen extends StatelessWidget {
  CustomerBottomWidgetScreen({super.key});

  final AuthController authController = AuthController();

  final List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    CustomerProfileScreen()
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
      child: Consumer<UiProvider>(builder: (context, pageController, child) {
        return Scaffold(
            body: screens[pageController.pageControlSelectedIndex],
            bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: blackColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 16.0,
                unselectedFontSize: 16.0,
                type: BottomNavigationBarType.shifting,
                currentIndex: pageController.pageControlSelectedIndex,
                onTap: (index) {
                  pageController.updatePageControllerSelectedValue(index);
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
                        Icons.shopping_cart,
                      ),
                      label: bottomCart),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                      ),
                      label: bottomProfile)
                ]));
      }),
    );
  }
}
