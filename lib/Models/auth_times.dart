

import 'package:flutter/widgets.dart';

class AuthTime extends ChangeNotifier {

  int tries = 0;

  changeTries (int value) {
    tries = value; 
    notifyListeners();
  }
}