import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static String isLoggedInKey = 'isLoggedIn';

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, value);
  }
  
  static Future<String?> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool(isLoggedInKey) ?? false;

  if (isLoggedIn) {
    // Kullanıcı giriş yapmış, userId'yi al
    String? userId = prefs.getString('userId');
    return userId;
  }

  return null;
}



}
