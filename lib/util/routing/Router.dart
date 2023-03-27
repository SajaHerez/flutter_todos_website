
import 'package:flutter/material.dart';
import '../../data/model/task.dart';
import '../../screen/activities/activities_page.dart';
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
            builder: (context) =>  HomeScreen());
                 case RouterName.activitiesScreen:
        return MaterialPageRoute(
            builder: (context) =>  ActivitiesScreen(task:settings.arguments as Task,));
      default:
        return RoutingUtil.errorRoute();
    }
  }
}
