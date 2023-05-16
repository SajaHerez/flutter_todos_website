import 'package:flutter/material.dart';
import 'package:flutter_todos_website/data/service/user_controller.dart';
import 'package:flutter_todos_website/util/style/appColors.dart';
import 'package:flutter_todos_website/util/style/spaces.dart';
import 'package:flutter_todos_website/util/style/textStyle.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../data/service/task_controller.dart';
import '../../util/routing/RoutingUilites.dart';
import '../widget/custom_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final p1 = context
        .watch<TaskController>()
        .percentageCompletedTask
        .toStringAsFixed(1);
    final p2 =
        context.watch<TaskController>().percentageDailyTask.toStringAsFixed(1);

    return Scaffold(
      appBar: customAppBar(context),
      body: Center(
        child: Container(
            alignment: Alignment.center,
            height: 800,
            width: 1000,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      RoutingUtil.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: AppColors.white,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SpacesHelper.verticalSpace(60),
                        Text(
                          "Total Competeted Tasks ",
                          style: TextStyles.titleStyleLogo,
                        ),
                        SpacesHelper.verticalSpace(25),
                        Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                              color: AppColors.darkGray,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 79, 76, 76)
                                      .withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                )
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              SpacesHelper.verticalSpace(20),
                              Text(
                                'Average Total Competeted:',
                                style: TextStyles.snakTextStyle2,
                              ),
                              SpacesHelper.verticalSpace(35),
                              LinearPercentIndicator(
                                  alignment: MainAxisAlignment.center,
                                  width: 300.0,
                                  barRadius: const Radius.circular(50),
                                  lineHeight: 25.0,
                                  percent: context
                                      .watch<TaskController>()
                                      .percentageCompletedTask,
                                  animationDuration: 800,
                                  animation: true,
                                  center: Text(
                                    "${double.parse(p1) * 100}%",
                                    style: const TextStyle(
                                        fontSize: 12.0, color: AppColors.white),
                                  ),
                                  backgroundColor: Colors.white60,
                                  progressColor: Colors.black38),
                            ],
                          ),
                        )
                      ],
                    ),
                    SpacesHelper.horizontalSpace(35),
                    Column(
                      children: [
                        SpacesHelper.verticalSpace(60),
                        Text(
                          "Tasks Progress Today",
                          style: TextStyles.titleStyleLogo,
                        ),
                        SpacesHelper.verticalSpace(25),
                        Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                              color: AppColors.darkGray,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 79, 76, 76)
                                      .withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                )
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              SpacesHelper.verticalSpace(20),
                              Text(
                                'Average Progress per Day:',
                                style: TextStyles.snakTextStyle2,
                              ),
                              SpacesHelper.verticalSpace(35),
                              LinearPercentIndicator(
                                  alignment: MainAxisAlignment.center,
                                  width: 300.0,
                                  barRadius: const Radius.circular(50),
                                  lineHeight: 25.0,
                                  percent: context
                                      .watch<TaskController>()
                                      .percentageDailyTask,
                                  animationDuration: 800,
                                  animation: true,
                                  center: Text(
                                    "${double.parse(p2) * 100}%",
                                    style: const TextStyle(
                                        fontSize: 12.0, color: AppColors.white),
                                  ),
                                  backgroundColor: Colors.white60,
                                  progressColor: Colors.black38),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
