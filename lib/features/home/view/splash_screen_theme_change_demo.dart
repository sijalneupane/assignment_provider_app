import 'package:flutter/material.dart';
import 'package:provider_test1/features/home/view/change_theme_POC.dart';
import 'package:provider_test1/widgets/custom_app_bar.dart';

class SplashScreenThemeChangeDemo extends StatefulWidget {
  const SplashScreenThemeChangeDemo({super.key});

  @override
  State<SplashScreenThemeChangeDemo> createState() => _SplashScreenThemeChangeDemoState();
}

class _SplashScreenThemeChangeDemoState extends State<SplashScreenThemeChangeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(child: Image.asset("assets/images/sizz-logo.png"),),
          Positioned(
            bottom: 30,
            // left: double.infinity,
            // right: double.infinity,
            child: 
          CircularProgressIndicator(),),
          Positioned(child: ElevatedButton(onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ChangeThemePoc()),
          );
          }, child:Text("GO to change theme"),),),
        ]
          
      ),
    );
  }
}