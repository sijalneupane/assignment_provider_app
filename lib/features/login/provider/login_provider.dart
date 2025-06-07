import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider_test1/features/login/model/login_model.dart';
import 'package:provider_test1/features/login/model/signup_model.dart';
import 'package:provider_test1/features/login/service/login_service.dart';
import 'package:provider_test1/features/login/service/login_service_impl.dart';
import 'package:provider_test1/utils/api_response.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  List<String> genderList = ["male", "female", "Others"];
  // List<String> roleList = ["admin", "user"];
  List<String> roleList = ["teacher", "student", "admin"];
  String? gender, role;
  bool loginPasswordVisible = false;
  bool registerPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String? loginErrorMessage;
  bool? rememberMe = false;

  //network status for register
  NetworkStatus _registerStatus = NetworkStatus.idle;

  NetworkStatus get getRegisterStatus => _registerStatus;

  LoginRegisterSerice loginService = LoginServiceImpl();

  setRegisterStatus(NetworkStatus networkStatus) {
    _registerStatus = networkStatus;
    notifyListeners();
  }

  registerUser() async {
    setRegisterStatus(NetworkStatus.loading);

    SignupModel model = SignupModel(
      name: nameController.text,
      username: usernameController.text,
      password: passwordController.text,
      contact: contactController.text,
      role: role,
      gender: gender,
      email: emailController.text,
    );

    ApiResponse response = await loginService.register(model);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setRegisterStatus(NetworkStatus.success);
    } else {
      setRegisterStatus(NetworkStatus.error);
    }
  }

  changeLoginVisibility() {
    loginPasswordVisible = !loginPasswordVisible;
    notifyListeners();
  }

  changeRegisterVisibility() {
    registerPasswordVisible = !registerPasswordVisible;
    notifyListeners();
  }

  changeRememberMe(bool? value) {
    rememberMe = value;
    notifyListeners();
  }

  NetworkStatus get getLoginStatus => _loginStatus;
  NetworkStatus _loginStatus = NetworkStatus.idle;
  setLoginStatus(NetworkStatus networkStatus) {
    _loginStatus = networkStatus;
    notifyListeners();
  }

  loginUser() async {
    setLoginStatus(NetworkStatus.loading);
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      LoginModel loginModel = LoginModel(
        email: emailController.text,
        password: passwordController.text,
        deviceToken: deviceToken,
      );
      ApiResponse response = await loginService.login(loginModel);
      if (response.networkStatus == NetworkStatus.success) {
        clearFormFields();
        // Obtain shared preferences.
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String token = response.data["token"];
        final String role = response.data["role"];
        final String email = response.data["email"];
        final String id = response.data["id"].toString();
        final String username = response.data["username"];
        final String name = response.data["name"];
        prefs.setString("token", token);
        prefs.setString("role", role);
        setLoginStatus(NetworkStatus.success);
        saveRememberMeValue();
        saveUserCredentials(role: role, email: email, username: username, name: name,id:id);
      } else {
        setLoginStatus(NetworkStatus.error);
      }
    } on Exception {
      loginErrorMessage = "Failed to get Device Info, Connect to internet";
      setLoginStatus(NetworkStatus.error);
    }
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   usernameController.dispose();
  //   contactController.dispose();
  //   nameController.dispose();
  //   role = null;
  //   gender = null;

  //   super.dispose();
  // }
  void clearFormFields() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    contactController.clear();
    nameController.clear();
    role = null;
    gender = null;
    notifyListeners();
  }

  validateEmail(String? value) {
    if (value!.isEmpty) {
      return emailValidationStr;
    }
    return null;
  }

  validatePassword(String? value) {
    if (value!.isEmpty) {
      return passwordValidationStr;
    }
    return null;
  }

  Future<void> saveRememberMeValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', rememberMe ?? false);
  }

  Future<void> saveUserCredentials({
    required String role,
    required String email,
    required String username,
    required String name,
    required String id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('role', role);
    await prefs.setString('email', email);
    await prefs.setString('username', username);
    await prefs.setString('name', name);
  }
}
