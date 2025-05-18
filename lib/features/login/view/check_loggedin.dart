// import 'package:api_testing_app/bottom_navbar1.dart';
// import 'package:api_testing_app/login1.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CheckLoggedin extends StatefulWidget {
//   const CheckLoggedin({super.key});

//   @override
//   State<CheckLoggedin> createState() => _CheckLoggedinState();
// }

// class _CheckLoggedinState extends State<CheckLoggedin> {
//   bool? isLoggedIn;
//   @override
//   void initState() {
//     super.initState();
//     checkLoggedIn();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return (isLoggedIn == true) ? BottomNavbar1() : Login1();
    
//   }

//   checkLoggedIn() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
//     setState(() {
//       isLoggedIn;
//     });
//   }
// }
