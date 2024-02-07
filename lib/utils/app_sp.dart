
import 'package:shared_preferences/shared_preferences.dart';


class  SharedPrefrence{

  Future<bool> setIsLogged(bool login) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isLogged", login);
  }

  Future<bool> getIsLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogged") ?? false;
  }

  Future<bool> setIsAppLaunched(bool onceOpen) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isAppLaunched", onceOpen);
  }

  Future<bool> getIsAppLaunched() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isAppLaunched") ?? false;
  }
  Future<bool> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? '';
  }


}
