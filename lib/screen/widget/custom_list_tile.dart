import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../util/style/appColors.dart';
import '../../util/style/spaces.dart';
import '../../util/style/textStyle.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key,
      required this.createdAt,
      required this.title,
      required this.deleteOnTap,
      required this.editOnTap,
      required this.cancelOnTap,
      required this.onChanged,
      required this.onTap,
      required this.getPercent,
      this.isDone = false,
      this.isCancelled = false});
  final String title;
  final String createdAt;
  void Function() deleteOnTap;
  void Function() editOnTap;
  void Function() cancelOnTap;
  void Function(bool?)? onChanged;
  void Function()? onTap;
  double Function() getPercent;
  bool isDone;
  bool isCancelled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 79, 76, 76).withOpacity(0.4),
                  spreadRadius: 4,
                  blurRadius: 8,
                )
              ],
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  AppColors.simeblue2,
                  AppColors.simegreen2,
                ],
              )),
          child: Column(
            children: [
              Text(title, style: getStyle(isDone, isCancelled)),
              SpacesHelper.verticalSpace(55),
              Align(
                alignment: Alignment.center,
                child: LinearPercentIndicator(
                    width: 160.0,
                    barRadius: const Radius.circular(10),
                    lineHeight: 14.0,
                    percent: getPercent(),
                    animationDuration: 800,
                    animation: true,
                    center: Text(
                      "${getPercent() * 100}%",
                      style: const TextStyle(
                          fontSize: 12.0, color: AppColors.white),
                    ),
                    backgroundColor: Colors.white60,
                    progressColor: Colors.black38),
              ),
              SpacesHelper.verticalSpace(20),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                      activeColor: AppColors.green,
                      value: isDone,
                      onChanged: isCancelled == true ? null : onChanged),
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                        PopupMenuItem(
                          value: 'cancel',
                          child: Row(
                            children: [
                              const Text("Cancel"),
                              if (isCancelled)
                                const Icon(
                                  Icons.check,
                                  color: AppColors.red,
                                )
                            ],
                          ),
                        )
                      ];
                    },
                    onSelected: (String value) {
                      if (value == 'edit') {
                        editOnTap();
                      } else if (value == 'delete') {
                        deleteOnTap();
                      } else if (value == 'cancel') {
                        cancelOnTap();
                      }
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(createdAt, style: TextStyles.smallTextStyle),
              ),
            ],
          )),
    );
  }
}

TextStyle getStyle(isDone, isCancelled) {
  if (isCancelled) {
    return TextStyles.cancelledTitleStyle;
  } else if (isDone) {
    return TextStyles.doneTitleStyle;
  } else {
    return TextStyles.titleStyle3;
  }
}
