import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("TOKEN", token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("TOKEN");
  }

  Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    var bool = await prefs.remove("TOKEN");
    return bool;
  }
}
