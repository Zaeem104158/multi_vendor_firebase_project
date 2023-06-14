import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int pageControlSelectedIndex = 0;
  int radioTileSelectedValue = 1;
  bool isPasswordVisible = false;
  // ! Payment screen payment type provider
  void updateRadioTileSelectedValue(int value) {
    radioTileSelectedValue = value;
    notifyListeners();
  }

  // ! Customer and seller Homescreen page controller provider
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
