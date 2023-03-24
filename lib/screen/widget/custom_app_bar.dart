import 'package:flutter/material.dart';
import '../../util/constant/pathes.dart';
import '../../util/style/appColors.dart';
import '../../util/style/textStyle.dart';

 AppBar customAppBar(){
   return AppBar(
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
          ));
  }