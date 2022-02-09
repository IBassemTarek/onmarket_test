import 'package:get/state_manager.dart';
import 'package:onmarket_test/Screens/cartPage/cart_page.dart';
import 'package:onmarket_test/Screens/mainScreen/main_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarModel extends GetxController {
  Widget _currentScreen =   MainScreen();
  int _navigationValue = 0;
  get navigationValue => _navigationValue;
  get currentScreen => _currentScreen;
  void chnageSelectedValue(int selectedValue) {
    _navigationValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          _currentScreen =   MainScreen();
          break;
        }
      case 1:
        {
          _currentScreen = const CartPage();
          break;
        }
      default:
    }
    update();
  }
}
