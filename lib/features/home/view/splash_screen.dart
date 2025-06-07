import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/home/provider/splash_screen_provider.dart';
import 'package:provider_test1/features/home/view/change_theme_POC.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/widgets/custom_app_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () async{
      SplashScreenProvider splashScreenProvider =
          Provider.of<SplashScreenProvider>(context, listen: false);
     await  splashScreenProvider.getRememberMeValue();
      if (splashScreenProvider.rememberMe == false ||
          splashScreenProvider.rememberMe == null) {
        RouteGenerator.navigateToPageWithoutStack(context, Routes.loginRoute);
      } else {
        RouteGenerator.navigateToPageWithoutStack(context, Routes.bottomNavbarRoute);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(child: Image.asset("assets/images/sizz-logo.png")),
          Positioned(
            bottom: 100,
            left: MediaQuery.of(context).size.width * 0.5 - 20,
            // left: double.infinity,
            // right: double.infinity,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
