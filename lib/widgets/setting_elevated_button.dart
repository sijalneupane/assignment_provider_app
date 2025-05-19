import 'package:flutter/material.dart';
import 'package:provider_test1/utils/custom_icons.dart';
import 'package:provider_test1/utils/dialog_box.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingElevatedButton extends StatelessWidget {
  String data;
  Widget Function(BuildContext) builder;
  bool? logout;
  IconData? icon;
  Color? backgroundColor;
  SettingElevatedButton({
    super.key,
    required this.data,
    required this.builder,
    this.logout,
    this.icon,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.03,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.07,
        child: ElevatedButton(
          onPressed: () async {
            if (logout ?? false) {
              //if logout button is pressed

              DialogBox.showConfirmBox(
                context: context,
                title: logoutStr,
                message: confirmLogoutStr,
                onOkPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("authToken");
                  prefs.remove("isLoggedIn");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: builder),
                    (Route<dynamic> route) => false,
                  );
                },
              );
              //     showDialog(
              //         context: context,
              //         builder: (context) => AlertDialog(
              //               title: Text(
              //                 logoutStr,
              //                 style: TextStyle(color: Colors.red),
              //               ),
              //               content: Text(confirmLogoutStr),
              //               actions: [
              //                 TextButton(
              //                   onPressed: () {
              //                     Navigator.of(context)
              //                         .pop(false); // Dismiss and return false
              //                   },
              //                   child: Text(cancelStr),
              //                 ),
              //                 TextButton(
              //                   onPressed: () {
              //                     Navigator.of(context)
              //                         .pop(true); // Dismiss and return true
              //                   },
              //                   child: Text(confirmStr),
              //                 ),
              //               ],
              //             )).then((value) async {
              //       if (value == true) {
              //         final SharedPreferences prefs =
              //             await SharedPreferences.getInstance();
              //         prefs.remove("authToken");
              //         prefs.remove("isLoggedIn");
              //         Navigator.pushAndRemoveUntil(
              //             context,
              //             MaterialPageRoute(builder: builder),
              //             (Route<dynamic> route) => false);
              //       }
              //     });
              //   } else {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: builder,
              //         ));
            }
          },
          child: Row(
            children: [
              CustomIcons(icon: icon),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              CustomText(data: data, color: Colors.white, fontSize: 16),
              Spacer(),
              CustomIcons(icon: Icons.arrow_forward_ios),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
