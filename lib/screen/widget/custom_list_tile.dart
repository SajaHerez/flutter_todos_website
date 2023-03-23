import 'package:flutter/material.dart';

import '../../util/style/appColors.dart';
import '../../util/style/spaces.dart';
import '../../util/style/textStyle.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key,
      required this.title,
      required this.deleteOnTap,
      required this.editOnTap,
      required this.cancelOnTap,
      this.isDone = false,
      this.isCancelled = false});
  final String title;
  void Function() deleteOnTap;
  void Function() editOnTap;
  void Function() cancelOnTap;
  bool isDone;
  bool isCancelled;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            SpacesHelper.verticalSpace(85),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                    value: isDone,
                    onChanged: (value) {
                      isDone = value ?? false;
                      print("the is Done value $isDone");
                    }),
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
                      const PopupMenuItem(
                        value: 'cancel',
                        child: Text('Cancel'),
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

                // GestureDetector(
                //   onTap: rightOnTap,
                //   child: const Icon(
                //     Icons.delete,
                //   ),
                // )
              ],
            )
          ],
        ));
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
