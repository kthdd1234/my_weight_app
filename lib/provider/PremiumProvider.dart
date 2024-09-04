import 'package:flutter/material.dart';

class PremiumProvider with ChangeNotifier {
  bool isPremium = true;

  bool premiumValue() {
    return isPremium;
  }

  setPremiumValue(bool newValue) {
    isPremium = newValue;
    notifyListeners();
  }
}
