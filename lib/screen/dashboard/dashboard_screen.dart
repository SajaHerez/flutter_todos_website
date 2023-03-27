import 'package:flutter/material.dart';
import 'package:flutter_todos_website/util/style/appColors.dart';
import 'package:flutter_todos_website/util/style/spaces.dart';
import 'package:flutter_todos_website/util/style/textStyle.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../data/service/task_controller.dart';
import '../widget/custom_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double progress =
        Provider.of<TaskController>(context, listen: true).getTodayProgress();
    return Scaffold(
      appBar: customAppBar(),
      body: Center(
        child: Column(
          children: [
            SpacesHelper.verticalSpace(150),
            Text(
              "Tasks Progress Today",
              style: TextStyles.titleStyle,
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
                      percent: progress,
                      animationDuration: 800,
                      animation: true,
                      center: Text(
                        "${progress * 100}%",
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
      ),
    );
  }
}
