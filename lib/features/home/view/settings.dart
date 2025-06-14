import 'package:flutter/material.dart';
import 'package:provider_test1/features/assignment/view/add_assignment.dart';
import 'package:provider_test1/features/assignment/view/get_assignment.dart';
import 'package:provider_test1/features/login/view/login1.dart';
import 'package:provider_test1/utils/dialog_box.dart';
import 'package:provider_test1/utils/get_token_role.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/setting_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(settingStr)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SettingElevatedButton(
              icon: Icons.add_sharp,
              // backgroundColor: Colors.green,
              data: addAssignmentStr,
              onPressed: () {
                RouteGenerator.navigateToPage(
                  context,
                  Routes.addAssignment,
                  arguments: null,
                );
              },
            ),
            SettingElevatedButton(
              icon: Icons.format_list_numbered,
              // backgroundColor: Colors.blue,
              data: getAssignmentStr,
              onPressed: () {
                RouteGenerator.navigateToPage(context, Routes.getAssignment);
              },
            ),
            FutureBuilder<String>(
              future: GetTokenRole().getRole(),
              builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox.shrink();
              }
              if (snapshot.hasData && snapshot.data == "admin") {
                return SettingElevatedButton(
                icon: Icons.admin_panel_settings,
                data: "Admin Panel",
                onPressed: () {
                  // Navigate to admin panel or perform admin action
                  RouteGenerator.navigateToPage(context, Routes.addNoticeRoute);
                },
                );
              }
              return SizedBox.shrink();
              },
            ),
            SettingElevatedButton(
              data: getNoticeStr,
              icon: Icons.image_search,
              // backgroundColor: Colors.blue,
              onPressed: () {
                RouteGenerator.navigateToPage(context, Routes.getNoticeRoute);
              },
            ),
            SettingElevatedButton(
              borderColor: Colors.red,
              data: logoutStr,
              icon: Icons.logout,

              backgroundColor: Colors.red,
              foregroundColor: Colors.white,

              onPressed: () async {
                DialogBox.showConfirmBox(
                  context: context,
                  title: logoutStr,
                  message: confirmLogoutStr,
                  onOkPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove("authToken");
                    await prefs.remove("isLoggedIn");
                    await prefs.remove("rememberMe");

                    RouteGenerator.navigateToPageWithoutStack(
                      context,
                      Routes.loginRoute,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
