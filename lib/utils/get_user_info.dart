import 'package:provider_test1/features/home/model/currentuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserInfo {
  static String? authToken;
  static CurrentUser? currentUser;
  //  Future<String> getRole() async {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //    String role= prefs.getString("role")??'';
  //    return role;
  //   }

  Future<void> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("token");
  }

  saveCurrentUserInfo(CurrentUser? currentUser) {
    currentUser = currentUser;
  }

  getCurrentUser() {
    return currentUser;
  }
}
