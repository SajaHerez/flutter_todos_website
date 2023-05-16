import 'package:flutter/material.dart';
import 'package:flutter_todos_website/data/service/task_controller.dart';
import 'package:flutter_todos_website/util/routing/RouterNamed.dart';
import 'package:flutter_todos_website/util/routing/RoutingUilites.dart';
import '../../data/service/user_controller.dart';
import '../../util/constant/pathes.dart';
import '../../util/style/appColors.dart';
import '../../util/style/textStyle.dart';
import 'package:provider/provider.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    elevation: 8,
    leadingWidth: 100,
    leading: Container(
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
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 50),
          child: Row(
            children: [
              const Icon(
                Icons.person,
                color: AppColors.darkGray,
                size: 33,
              ),
              Text(
                Provider.of<UserController>(context, listen: true).getUser.name,
                style: TextStyles.imageDescriptionTextStyle,
              ),
            ],
          )),
      Container(
        margin: const EdgeInsets.only(right: 30),
        child: IconButton(
            onPressed: () {
              context.read<TaskController>().percentageOfCompletedTask(
                  context.read<UserController>().getUser.id);
              context.read<TaskController>().percentageOfDailyTask(
                  context.read<UserController>().getUser.id,
                  DateTime.now().toString().substring(0, 10));
              print(DateTime.now().toString().substring(0, 10));
              RoutingUtil.push(RouterName.dashboardScreen);
            },
            icon: const Icon(
              Icons.dashboard_rounded,
              color: AppColors.darkGray,
              size: 33,
            )),
      ),
      Container(
        margin: const EdgeInsets.only(right: 150),
        child: IconButton(
            onPressed: () async {
              await Provider.of<UserController>(context, listen: false).singOut(
                  user_id: Provider.of<UserController>(context, listen: false)
                      .getUser
                      .id);
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.darkGray,
              size: 33,
            )),
      ),
    ],
  );
}
