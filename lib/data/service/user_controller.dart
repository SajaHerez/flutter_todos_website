import 'package:flutter/material.dart';
import 'package:flutter_todos_website/data/api/end_point.dart';
import 'package:flutter_todos_website/data/local/local_storage.dart';
import 'package:flutter_todos_website/data/service/task_controller.dart';
import 'package:provider/provider.dart';

import '../../ID/locator.dart';
import '../../util/routing/RouterNamed.dart';
import '../../util/routing/RoutingUilites.dart';
import '../api/auth_api.dart';
import '../model/user.dart';

class UserController extends ChangeNotifier {
  late User _user;
  AuthAPI authApi = getIt<AuthAPI>();
  bool islogin = false;
  void setUser(user) {
    _user = user;
    notifyListeners();
  }

  void isLogin(bool value) {
    islogin = value;
    notifyListeners();
  }

  User get getUser => _user;

  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    final response = await authApi.signUp(
        path: Endpoint.signUp, email: email, password: password, name: name);
    print(response);
    if (response.data['code'] == 200) {
      RoutingUtil.pushReplacement(RouterName.loginScreen);
    }
  }

  Future<void> signIn({
    context,
    required String email,
    required String password,
  }) async {
    final response = await authApi.signIn(
        path: Endpoint.signIn, email: email, password: password);

    if (response.data['code'] == 200) {
      final user = User.fromJson(response.data['data']);
      await getIt<LocalStorage>().saveUserData(user);
      setUser(await getIt<LocalStorage>().getUserData());
      await getIt<LocalStorage>().setIsLogged(true);
      await Provider.of<TaskController>(context, listen: false)
          .getNotes(user_id: getUser.id);
      RoutingUtil.pushReplacement(RouterName.homeScreen);
    }
  }

  Future<void> singOut({required String user_id}) async {
    final response =
        await authApi.singOut(path: Endpoint.logout, user_id: user_id);
    if (response.data['code'] == 200) {
      getIt<LocalStorage>().setIsLogged(false);
      await getIt<LocalStorage>().removeUserData();
      RoutingUtil.pushReplacement(RouterName.splashScreen);
    }
  }
}
