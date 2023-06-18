import 'package:flutter/material.dart';

class L10n {
  static final all = [const Locale('en'), const Locale('bn')];
  static String getFlag(String code) {
    switch (code) {
      case 'bn':
        return '🇧🇩';
      case 'en':
        return '🇺🇸';
      default:
        return 'us';
    }
  }
}
