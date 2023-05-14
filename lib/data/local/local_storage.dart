import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class LocalStorage {
  LocalStorage(this.pref);
  SharedPreferences pref;
  Future<void> saveUserData(User user) async {
    await pref.setString("id", user.id);
    await pref.setString("email", user.email);
    await pref.setString("name", user.name);
  }

  Future<User> getUserData() async {
    String? id = pref.getString("id");
    String? email = pref.getString("email");
    String? fullName = pref.getString("name");

    return User(id: id ?? "", name: fullName ?? '', email: email ?? '');
  }

  Future<void> removeUserData() async {
    pref.remove("id");
    pref.remove("email");
    pref.remove("name");
  }

  Future<void> setIsLogged(bool isLogged) async {
    await pref.setBool("is_logged", isLogged);
  }

  Future<bool?> IsLogged() async {
    if (pref.containsKey("is_logged")) {
      return await pref.getBool("is_logged");
    }
    return false;
  }
}
