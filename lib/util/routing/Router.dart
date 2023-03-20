
import 'package:flutter/material.dart';
import '../../screen/home/home_page.dart';
import '../../screen/sign in/sign_in_page.dart';
import '../../screen/sign up/sign_up_page.dart';
import 'RouterNamed.dart';
import 'RoutingUilites.dart';

class Routers {
  Routers._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
       case RouterName.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case RouterName.loginScreen:
        return MaterialPageRoute(builder: (context) =>   LoginScreen());
             case RouterName.homeScreen:
        return MaterialPageRoute(
            builder: (context) => const HomeScreen());
      default:
        return RoutingUtil.errorRoute();
    }
  }
}
