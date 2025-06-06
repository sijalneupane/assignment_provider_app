//https://l.facebook.com/l.php?u=https%3A%2F%2F6a2b-2407-1400-aa0b-9848-39ee-108b-965d-7c1b.ngrok-free.app%2FcreateUser&h=AT2pVAX6aYuVyH87EIeHF7joEk8-JuW1hEaU1DCGpLEQqh_tAIfjQqXIxFECmikTFza4_YhNSbMCAWkK5_1ygxL_JbLHurZHDjYK0OXrqDc9xiEeUovxvJQ8K2WkzzgL2-rtReJfB8Lz41w&s=1

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/login/provider/login_provider.dart';
import 'package:provider_test1/features/login/view/login1.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/background_imgae.dart';
import 'package:provider_test1/utils/custom_inkwell.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/spin_kit.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_app_bar.dart';
import 'package:provider_test1/widgets/custom_dropdown.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_text.dart';
import 'package:provider_test1/widgets/custom_textformfield.dart';
import 'package:provider_test1/widgets/custom_textformfield_carrental.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(registerStr)),
      body: Consumer<LoginProvider>(
        builder:
            (context, loginProvider, child) => SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  BackgroundImage(),
                  _ui(loginProvider),
                  loginProvider.getRegisterStatus == NetworkStatus.loading
                      ? Loader.backdropFilter(context)
                      : SizedBox(),
                ],
              ),
            ),
      ),
    );
  }

  Widget _ui(LoginProvider loginProvider) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomAppBar(
                hasBackButton: true,
                middleChild: CustomText(data: registerStr,isPageTitle: true,),
              ),
              CustomTextformfield(
                keyboardType: TextInputType.emailAddress,
                controller: loginProvider.emailController,
                labelText: emailStr,
                suffixIcon: Icon(Icons.email),
              ),
              CustomTextformfield(
                controller: loginProvider.usernameController,
                labelText: usernameStr,
              ),
              CustomTextformfield(
                keyboardType: TextInputType.visiblePassword,
                controller: loginProvider.passwordController,
                labelText: passwordStr,
                obscureText:
                    loginProvider.registerPasswordVisible ? false : true,
                suffixIcon: IconButton(
                  onPressed: () {
                    loginProvider.changeRegisterVisibility();
                  },
                  icon:
                      loginProvider.registerPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                ),
              ),
              CustomTextformfield(
                controller: loginProvider.nameController,
                labelText: nameStr,
              ),
              CustomDropdown(
                labelText: genderStr,
                dropDownItemList: loginProvider.genderList,
                onChanged: (value) {
                  loginProvider.gender = value;
                },
              ),
              CustomDropdown(
                labelText: roleStr,
                dropDownItemList: loginProvider.roleList,
                onChanged: (value) {
                  loginProvider.role = value;
                },
              ),
              CustomTextformfield(
                keyboardType: TextInputType.number,
                controller: loginProvider.contactController,
                labelText: contactStr,
              ),
              CustomElevatedbutton(
                child:
                    loginProvider.getRegisterStatus == NetworkStatus.loading
                        ? CircularProgressIndicator()
                        : Text(registerStr),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await loginProvider.registerUser();
                    if (loginProvider.getRegisterStatus ==
                        NetworkStatus.success) {
                      displaySnackBar(context, registerMessageStr);
                      RouteGenerator.navigateToPage(context, Routes.loginRoute);
                    } else if (loginProvider.getRegisterStatus ==
                        NetworkStatus.error) {
                      displaySnackBar(context, registerMessageFailedStr);
                    }
                  }
                },
              ),
              CustomOnTapLink(
                data: alreadyRegisteredStr,
                onTap: () {
                  loginProvider.clearFormFields();
                  RouteGenerator.navigateToPage(context, Routes.loginRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
