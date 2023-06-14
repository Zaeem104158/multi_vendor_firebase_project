import 'package:firebase_multi_vendor_project/models/productdata_model_class.dart';
import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  final PageController pageController =
      PageController(viewportFraction: 0.7, initialPage: 1);
  int bottomNavigationControlSelectedIndex = 0;
  int pageControlSelectedIndex = 1;
  int radioTileSelectedValue = 1;
  bool isPasswordVisible = false;
  ProductDataModel? productData;
  void updateSelectedProductModelData(ProductDataModel data) {
    productData = data;
    notifyListeners();
  }

  // ! Payment screen payment type provider
  void updateRadioTileSelectedValue(int value) {
    radioTileSelectedValue = value;
    notifyListeners();
  }

  // ! Customer and seller Homescreen bottom navigationbar controller provider
  void updateBottomNavigationBarSelectedValue(int index) {
    bottomNavigationControlSelectedIndex = index;
    notifyListeners();
  }

  void updatePageControllerSelectedValue(int index) {
    pageControlSelectedIndex = index;
    notifyListeners();
  }

  // ! Password visible toggle provider
  void updateIsVisibleValue() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
