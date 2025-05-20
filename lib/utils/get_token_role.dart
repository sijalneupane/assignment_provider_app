import 'package:shared_preferences/shared_preferences.dart';

class GetTokenRole {
  getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("role");
  }

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("token");
  }
}
