import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/home/view/bottom_navbar1.dart';
import 'package:provider_test1/features/login/provider/login_provider.dart';
import 'package:provider_test1/features/login/view/register1.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/custom_inkwell.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // List<String> genderList = ["Male", "Female", "Others"];
  // List<String> roleList = ["Admin", "User"];
  // String? gender, role;
  // bool visible = false;
  // TextEditingController emailController = TextEditingController();
  // TextEditingController usernameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(loginStr)),
      body: Consumer<LoginProvider>(
        builder:
            (context, loginProvider, child) => SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      CustomTextformfield(
                        controller: loginProvider.emailController,
                        labelText: emailStr,
                        suffixIcon: Icon(Icons.email),
                      ),
                      CustomTextformfield(
                        controller: loginProvider.passwordController,
                        labelText: passwordStr,
                        obscureText: loginProvider.loginPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: () {
                            loginProvider.changeLoginVisibility();
                          },
                          icon:
                              loginProvider.loginPasswordVisible
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                        ),
                      ),
                      CustomElevatedbutton(
                        child:loginProvider.getLoginStatus==NetworkStatus.loading?CircularProgressIndicator.adaptive(): Text(loginStr),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await loginProvider.loginUser();
                            if(loginProvider.getLoginStatus==NetworkStatus.success){
                              displaySnackBar(context, loginMessageStr);
                              RouteGenerator.navigateToPageWithoutStack(context,Routes.homeRoute);
                            }else if(loginProvider.getLoginStatus==NetworkStatus.error){
                              displaySnackBar(context, loginProvider.loginErrorMessage?? loginMessageFailedStr);
                            }
                          }
                        },
                      ),
                      CustomInkwell(
                        data: notRegisteredStr,
                        onTap: () {
                          loginProvider.clearFormFields();
                          RouteGenerator.navigateToPage(context, Routes.signupRoute);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
