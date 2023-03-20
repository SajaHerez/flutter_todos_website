import 'package:flutter/material.dart';
import 'package:flutter_todos_website/util/style/textStyle.dart';

import '../../data/model/mock/tasks.dart';
import '../../util/constant/pathes.dart';
import '../../util/style/appColors.dart';
import '../widget/custom_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 85,
          leading: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 30),
                  child:
                      Image.asset("${Pathes.iconPath}noteX74${Extension.png}")),
            ],
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
          )),
      body: Container(
        margin: const EdgeInsets.only(left: 40, right: 40, top: 60),
        child: Column(
          children: [
            GridView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.7,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CustomListTile(
                    title: tasks[index].title,
                    rightOnTap: () {},
                    leftOnTap: () {},
                  );
                })
          ],
        ),
      ),
    );
  }
}
