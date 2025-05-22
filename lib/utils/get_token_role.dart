import 'package:shared_preferences/shared_preferences.dart';

class GetTokenRole {
  getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   String role= prefs.getString("role")??'';
   return role;
  }

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   String token= prefs.getString("token") ?? '';
   return token;
  }
}
