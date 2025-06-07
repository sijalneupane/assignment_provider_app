import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenProvider with ChangeNotifier {
  bool? _rememberMe;
  bool? get rememberMe => _rememberMe;

  Future<void> getRememberMeValue() async {
    final prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs.getBool('rememberMe') ?? false;
  }
  

}