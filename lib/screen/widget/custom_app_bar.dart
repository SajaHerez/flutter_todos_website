import 'package:flutter/material.dart';
import 'package:flutter_todos_website/util/routing/RouterNamed.dart';
import 'package:flutter_todos_website/util/routing/RoutingUilites.dart';
import '../../util/constant/pathes.dart';
import '../../util/style/appColors.dart';
import '../../util/style/textStyle.dart';

AppBar customAppBar() {
  return AppBar(
    elevation: 8,
    leadingWidth: 100,
    leading: Container(
      //  width: ,
      margin: const EdgeInsets.only(left: 50),
      child: Column(
        children: [
          Image.asset(
            "${Pathes.iconPath}noteX74${Extension.png}",
          ),
        ],
      ),
    ),
    title: Text(
      "NoteY",
      style: TextStyles.titleStyleLogo,
    ),
    automaticallyImplyLeading: false,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
            AppColors.simeblue,
            AppColors.lightGreen,
          ])),
    ),
    actions: [
      Container(
        // width: 500,
        margin: const EdgeInsets.only(right: 250),
        child: IconButton(
            onPressed: () {
              RoutingUtil.push(RouterName.dashboardScreen);
            },
            icon: const Icon(
              Icons.dashboard_rounded,
              color: AppColors.darkGray,
              size: 33,
            )),
      )
    ],
  );
}
