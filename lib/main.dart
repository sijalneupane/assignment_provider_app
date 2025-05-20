import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/assignment/provider/assignment_provider.dart';
import 'package:provider_test1/features/assignment/view/get_assignment.dart';
import 'package:provider_test1/features/login/provider/login_provider.dart';
import 'package:provider_test1/features/login/view/login1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>LoginProvider()),
        ChangeNotifierProvider(create: (_)=>AssignmentProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home:Login()
        // home:GetAssignment()
      ),
    );
  }
}
