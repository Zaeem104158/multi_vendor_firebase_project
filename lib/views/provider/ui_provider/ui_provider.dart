import 'package:firebase_multi_vendor_project/l10n/l10n.dart';
import 'package:firebase_multi_vendor_project/models/productdata_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  // App localization
  Locale _locale = Locale("en");
  Locale get locale => _locale;
  Future<void> setLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    await prefs.setString(languageCodeKey, _locale.languageCode);
    notifyListeners();
  }

  Future<ThemeModeType> loadLocalMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String langCode = prefs.getString(languageCodeKey) ?? "en";
    _locale = Locale(langCode);
    notifyListeners();
    return _themeMode;
  }

  void clearLocale() {
    _locale = Locale("en");
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

  // ! Profile Screen
  bool isPhoneNumberEdit = false;
  void setIsPhoneNumberEdit() {
    isPhoneNumberEdit = !isPhoneNumberEdit;
    notifyListeners();
  }

  bool isImageEdit = false;
  void setImageEdit() {
    isImageEdit = !isImageEdit;
    notifyListeners();
  }

  bool isAddressEdit = false;
  void setAddressEdit() {
    isAddressEdit = !isAddressEdit;
    notifyListeners();
  }

  bool isFullNameEdit = false;
  void setFullNameEdit() {
    isFullNameEdit = !isFullNameEdit;
    notifyListeners();
  }

  // late AnimationController _controller;
  // late Animation<double> _animation;

  // AnimationProvider() {
  //   _controller = AnimationController(
  //     vsync: TickerProviderImpl(),
  //     duration: Duration(seconds: 1),
  //   );

  //   _animation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.easeInOut,
  //   );
  // }

  // Animation<double> get animation => _animation;

  // void startAnimation() {
  //   if (_controller.isCompleted) {
  //     _controller.reverse();
  //   } else {
  //     _controller.forward();
  //   }
  // }
}

class TickerProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
