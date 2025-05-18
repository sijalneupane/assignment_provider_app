
import 'package:flutter/material.dart';
import 'package:provider_test1/features/home/view/home1.dart';
import 'package:provider_test1/features/home/view/profile1.dart';
import 'package:provider_test1/features/home/view/settings.dart';
import 'package:provider_test1/utils/string_const.dart';

class BottomNavbar1 extends StatefulWidget {
  const BottomNavbar1({super.key});

  @override
  State<BottomNavbar1> createState() => _BottomNavbar1State();
}

class _BottomNavbar1State extends State<BottomNavbar1> {
  List<Widget> widgetList=[
    Home1(),
    Profile1(),
    Settings()
  ];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:widgetList[index] ,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100)
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          backgroundColor: Colors.white,
          selectedItemColor: const Color.fromARGB(255, 192, 9, 9),
          unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          // selectedLabelStyle: ,
          onTap: (value) {
        
            setState(() {
              index=value;
            });
          },
          currentIndex: index,
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label:homeStr),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label:profileStr),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label:settingStr),
        ]
        ),
      ),
    );
  }
}