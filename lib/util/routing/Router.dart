import 'package:flutter/material.dart';
import '../../data/model/note.dart';
import '../../screen/activities/activities_page.dart';
import '../../screen/dashboard/dashboard_screen.dart';
import '../../screen/home/home_page.dart';
import '../../screen/sign in/sign_in_page.dart';
import '../../screen/sign up/sign_up_page.dart';
import '../../screen/splash/splash_page.dart';
import 'RouterNamed.dart';
import 'RoutingUilites.dart';

class Routers {
  Routers._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouterName.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RouterName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouterName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      // case RouterName.activitiesScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => ActivitiesScreen(
      //             task: settings.arguments as Task,
      //           ));
      // case RouterName.dashboardScreen:
      //   return MaterialPageRoute(builder: (context) => const DashboardScreen());

      default:
        return RoutingUtil.errorRoute();
    }
  }
}
