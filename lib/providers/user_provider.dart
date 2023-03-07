import 'package:flutter/material.dart';
import 'package:isntagram/Resources/Auth_method.dart';
import 'package:isntagram/models/user.dart';

class UserProvider with ChangeNotifier {
  // instace of authMethods
  final AuthMethods _authMethods = AuthMethods();
  // instance of user model
  User? _user;
  // get method to get user
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    // notify all listeners to the provider that the value has changed and they have to update their values
    notifyListeners();
  }
}
