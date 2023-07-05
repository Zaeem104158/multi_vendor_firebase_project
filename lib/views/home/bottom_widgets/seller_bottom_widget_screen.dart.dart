import 'dart:io';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_multi_vendor_project/views/store/store_screen.dart';
import 'package:firebase_multi_vendor_project/views/upload_product/products_upload_screen.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/category/category_screen.dart';
import 'package:firebase_multi_vendor_project/views/dashboard/seller_dashboard_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SellerBottomWidgetScreen extends StatelessWidget {
  SellerBottomWidgetScreen({super.key});

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
                    //Seller Upload textEditing Controller Dispose.
                    // context.read<SellerProductsUploadController>().dispose();

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
      child: Consumer<UiProvider>(
          builder: (context, pageControllerProvider, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              //backgroundColor: blueGreyColor.shade600,
              selectedItemColor: blackColor,
              unselectedItemColor: Colors.grey,
              selectedFontSize: 16.0,
              unselectedFontSize: 16.0,
              type: BottomNavigationBarType.shifting,
              currentIndex:
                  pageControllerProvider.bottomNavigationControlSelectedIndex,
              onTap: (index) {
                pageControllerProvider
                    .updateBottomNavigationBarSelectedValue(index);
                dismissLoading();
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: AppLocalizations.of(context)!.home),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    label: AppLocalizations.of(context)!.category),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shop,
                    ),
                    label: AppLocalizations.of(context)!.shop),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard,
                    ),
                    label: AppLocalizations.of(context)!.dashboard),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.upload_file,
                    ),
                    label: AppLocalizations.of(context)!.upload)
              ]),
          body: screens[
              pageControllerProvider.bottomNavigationControlSelectedIndex],
        );
      }),
    );
  }
}
