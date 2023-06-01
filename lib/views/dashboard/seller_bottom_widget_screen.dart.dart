import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/category/category_screen.dart';
import 'package:firebase_multi_vendor_project/views/dashboard/seller_dashboard_screen.dart';
import 'package:firebase_multi_vendor_project/views/dashboard/seller_upload_products_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/home_screen.dart';
import 'package:firebase_multi_vendor_project/views/shop/shop_screen.dart';
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
    ShopScreen(),
    SellerDashBoardScreen(),
    SellerUploadProductsScreen()
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
    );
  }
}
