import 'package:ecommerce_app/models/user.dart';

import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? currentUser;

  void refreshUser(User newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
