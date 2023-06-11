import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/cart/cart_screen.dart';
import 'package:firebase_multi_vendor_project/views/category/category_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/home_screen.dart';
import 'package:firebase_multi_vendor_project/views/profie/customer_profile_screen.dart';
import 'package:firebase_multi_vendor_project/views/store/store_screen.dart';
import 'package:flutter/material.dart';

class CustomerBottomWidgetScreen extends StatefulWidget {
  CustomerBottomWidgetScreen({super.key});

  @override
  State<CustomerBottomWidgetScreen> createState() =>
      _CustomerBottomWidgetScreenState();
}

class _CustomerBottomWidgetScreenState
    extends State<CustomerBottomWidgetScreen> {
  final AuthController authController = AuthController();
  int selectedIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    CustomerProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
                  Icons.shopping_cart,
                ),
                label: bottomCart),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: bottomProfile)
          ]),
      body: screens[selectedIndex],
    );
  }
}
