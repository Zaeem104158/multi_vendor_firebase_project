import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/cart_screen.dart';
import 'package:firebase_multi_vendor_project/views/category_screen.dart';
import 'package:firebase_multi_vendor_project/views/home_screen.dart';
import 'package:firebase_multi_vendor_project/views/profile_screen.dart';
import 'package:firebase_multi_vendor_project/views/shop_screen.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final AuthController authController = AuthController();
  int selectedIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    ShopScreen(),
    CartScreen(),
    ProfileScreen()
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
                label: bottomSearch),
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
