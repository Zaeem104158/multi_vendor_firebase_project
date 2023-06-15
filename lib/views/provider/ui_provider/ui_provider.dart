import 'package:firebase_multi_vendor_project/models/productdata_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // ! Theme change
  ThemeModeType _themeMode = ThemeModeType.light;

  ThemeModeType get themeMode => _themeMode;

  Future<ThemeModeType> loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeModeIndex =
        prefs.getInt(themeModeKey) ?? ThemeModeType.light.index;
    _themeMode = ThemeModeType.values[themeModeIndex];
    notifyListeners();
    return _themeMode;
  }

  Locale _currentLocale = Locale('en');

  Locale get currentLocale => _currentLocale;

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(languageCodeKey);
    if (languageCode != null) {
      _currentLocale = Locale(languageCode);
    }
    notifyListeners();
  }

  Future<void> saveLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageCodeKey, locale.languageCode);
    _currentLocale = locale;
    notifyListeners();
  }

  Future<void> saveThemeMode(ThemeModeType themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeModeKey, themeMode.index);
    _themeMode = themeMode;
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
