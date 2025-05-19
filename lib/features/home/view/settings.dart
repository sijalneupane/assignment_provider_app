
import 'package:flutter/material.dart';
import 'package:provider_test1/features/assignment/view/add_assignment.dart';
import 'package:provider_test1/features/assignment/view/get_assignment.dart';
import 'package:provider_test1/features/login/view/login1.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/setting_elevated_button.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingStr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SettingElevatedButton(icon:Icons.add_sharp,backgroundColor: Colors.green, data:addAssignmentStr, builder: (context) =>AddAssignment() ,),
            SettingElevatedButton(icon: Icons.format_list_numbered,backgroundColor: Colors.blue, data:getAssignmentStr, builder: (context) =>GetAssignment() ,),
            SettingElevatedButton(icon:Icons.logout, data:logoutStr,backgroundColor: Colors.red,logout: true, builder: (context) =>Login() ,)
          ],
        ),
      ),
    );
  }
}