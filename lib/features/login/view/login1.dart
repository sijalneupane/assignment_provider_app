import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/home/view/bottom_navbar1.dart';
import 'package:provider_test1/features/login/provider/login_provider.dart';
import 'package:provider_test1/features/login/view/register1.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/background_imgae.dart';
import 'package:provider_test1/utils/custom_inkwell.dart';
import 'package:provider_test1/utils/hide_keyboard.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/spin_kit.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_text.dart';
import 'package:provider_test1/widgets/custom_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() async {
      Provider.of<LoginProvider>(
        context,
        listen: false,
      ).setLoginStatus(NetworkStatus.loading);
    });
    Future.delayed(Duration(seconds: 2), () {
      Provider.of<LoginProvider>(
        context,
        listen: false,
      ).setLoginStatus(NetworkStatus.idle);
      precacheImage(AssetImage("assets/images/logo.jpg"), context);
    });

    super.initState();
  }

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
      //  resizeToAvoidBottomInset: false,
      body: Consumer<LoginProvider>(
        builder:
            (context, loginProvider, child) => SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  BackgroundImage(),
                  _loginUi(loginProvider),
                  loginProvider.getLoginStatus == NetworkStatus.loading
                      ? Loader.backdropFilter(context)
                      : SizedBox(),
                ],
              ),
            ),
      ),
    );
  }

  _loginUi(LoginProvider loginProvider) {
    return SafeArea(
      child: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                CustomTextformfield(
                  controller: loginProvider.emailController,
                  labelText: emailStr,
                  suffixIcon: Icon(Icons.email),
                  validator: (value) {
                    return loginProvider.validateEmail(value);
                  },
                ),
                CustomTextformfield(
                  controller: loginProvider.passwordController,
                  labelText: passwordStr,
                  obscureText: loginProvider.loginPasswordVisible,
                  validator: (value) {
                    return loginProvider.validatePassword(value);
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      loginProvider.changeLoginVisibility();
                    },
                    icon:
                        loginProvider.loginPasswordVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                  ),
                ),Row(
                  children: [
                    Checkbox(
                      value:loginProvider.rememberMe,
                      onChanged:(value) {
                         loginProvider.changeRememberMe(value);
                      },
                    ),
                    CustomText(data: rememberMeStr),
                    const Spacer(),
                  ],
                ),
                CustomElevatedbutton(
                  child: Text(loginStr),
                  onPressed: () async {
                    HideKeyboard.hideKeyboard(context);
                    if (_formKey.currentState!.validate()) {
                      await loginProvider.loginUser();
                      if (loginProvider.getLoginStatus == NetworkStatus.success) {
                        displaySnackBar(context, loginMessageStr);
                        RouteGenerator.navigateToPageWithoutStack(
                          context,
                          Routes.bottomNavbarRoute,
                        );
                      } else if (loginProvider.getLoginStatus ==
                          NetworkStatus.error) {
                        displaySnackBar(
                          context,
                          loginProvider.loginErrorMessage ?? loginMessageFailedStr,
                        );
                      }
                    }
                  },
                ),
                
                CustomOnTapLink(
                  data: notRegisteredStr,
                  onTap: () {
                    RouteGenerator.navigateToPage(context, Routes.signupRoute);
                    loginProvider.clearFormFields();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
