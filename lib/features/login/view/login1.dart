
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider_test1/features/home/view/bottom_navbar1.dart';
import 'package:provider_test1/features/login/view/register1.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/custom_inkwell.dart';
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
  List<String> genderList = ["Male", "Female", "Others"];
  List<String> roleList = ["Admin", "User"];
  String? gender, role;
  bool visible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginStr),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              CustomTextformfield(
                controller: emailController,
                labelText: emailStr,
                suffixIcon: Icon(Icons.email),
              ),
              CustomTextformfield(
                  controller: passwordController,
                  labelText: passwordStr,
                  obscureText: visible ? false : true,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: visible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility))),
              CustomElevatedbutton(
                child: Text(loginStr),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var loginDataJson = {
                      "email": emailController.text,
                      "password": passwordController.text,
                    };

                    try {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Prevent dismissing the dialog
                        builder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                      Dio dio = Dio();
                      Response response = await dio.post(
                        ApiConst.baseUrl + ApiConst.loginApi,
                        data: loginDataJson,
                      );

                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString(
                            "authToken", response.data["token"]);
                        await prefs.setBool("isLoggedIn", true);

                        // Add a delay for the loading screen
                        await Future.delayed(Duration(milliseconds: 500));

                        // Close the loading indicator
                        Navigator.pop(context);

                        // Navigate to the next screen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => BottomNavbar1(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        Navigator.pop(context); // Close the loading indicator
                        displaySnackBar(context, loginMessageFailedStr);
                      }
                    } catch (e) {
                      Navigator.pop(context); // Close the loading indicator
                      displaySnackBar(context, e.toString());
                    }
                  }
                },
              ),
              CustomInkwell(
                data: notRegisteredStr,
                builder: (p0) => Register1(),
              )
            ],
          ),
        )),
      ),
    );
  }
}
