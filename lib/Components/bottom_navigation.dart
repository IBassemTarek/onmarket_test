import '../Utils/constants.dart';

import '../Controllers/bottom_bar_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget buttomNavigator() {
  return GetBuilder<BottomNavigationBarModel>(
    builder: (c) => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_cart_outlined),
          )
        ],
        selectedItemColor: kPrimaryColor,
        currentIndex: c.navigationValue,
        onTap: (index) {
          c.chnageSelectedValue(index);
        }),
  );
}
