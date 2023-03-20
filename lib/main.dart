import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todos_website/util/style/appColors.dart';
import 'util/routing/Router.dart';
import 'util/routing/RouterNamed.dart';
import 'util/routing/RoutingUilites.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1230, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: RoutingUtil.navigatorKey,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routers.onGenerateRoute,
          title: 'NoteY',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              scaffoldBackgroundColor: AppColors.simeBlack),
          initialRoute: RouterName.homeScreen,
        );
      },
    );
  }
}

