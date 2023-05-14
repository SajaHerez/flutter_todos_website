import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ID/locator.dart';
import '../../data/local/local_storage.dart';
import '../../data/service/user_controller.dart';
import '../../util/constant/pathes.dart';
import '../../util/routing/RouterNamed.dart';
import '../../util/routing/RoutingUilites.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    UserFlow();
    super.initState();
  }

  void UserFlow() {
    Future.delayed(const Duration(seconds: 3), () async {  
      RoutingUtil.pushReplacement(RouterName.loginScreen);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "${Pathes.iconPath}noteSplash${Extension.png}",
        ),
      ),
    );
  }
}
