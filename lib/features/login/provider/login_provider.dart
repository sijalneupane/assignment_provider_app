import 'package:flutter/material.dart';
import 'package:provider_test1/features/login/model/signup_model.dart';
import 'package:provider_test1/features/login/service/login_service.dart';
import 'package:provider_test1/features/login/service/login_service_impl.dart';
import 'package:provider_test1/utils/api_response.dart';
import 'package:provider_test1/utils/network_status.dart';

class LoginProvider extends ChangeNotifier {
  List<String> genderList = ["Male", "Female", "Others"];
  List<String> roleList = ["Admin", "User"];
  String? gender, role;
  bool visible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  NetworkStatus loginStatus = NetworkStatus.idle;
  // NetworkStatus get getLoginStatus=> _loginStatus;
LoginSerice loginService= LoginServiceImpl();

  setLoginStatus(NetworkStatus networkStatus) {
    loginStatus = networkStatus;
    notifyListeners();
  }

   loginUser()async {
    setLoginStatus(NetworkStatus.loading);

    SignupModel model = SignupModel(
      name: nameController.text,
      username: usernameController.text,
      password: passwordController.text,
      contact: contactController.text,
      role: role,
      gender: gender,
      email: emailController.text,
    );

   ApiResponse response= await loginService.login(model);
   if(response.statusCode==200 || response.statusCode==201){
   setLoginStatus(NetworkStatus.success);

   }else {
    setLoginStatus(NetworkStatus.error);
   }

  }

  changeVisibility() {
    visible = !visible;
    notifyListeners();
  }
}
