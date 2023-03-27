import 'package:flutter/material.dart';

import '../../util/style/appColors.dart';
import '../../util/style/spaces.dart';
import '../../util/style/textStyle.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {super.key,
      required this.createdAt,
      required this.title,
      required this.deleteOnTap,
      required this.editOnTap,
      required this.cancelOnTap,
      required this.onChanged,
      this.isDone = false,
      this.isCancelled = false});
  final String title;
  final String createdAt;
  void Function() deleteOnTap;
  void Function() editOnTap;
  void Function() cancelOnTap;
  void Function(bool?)? onChanged;
  bool isDone;
  bool isCancelled;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 85, 83, 83),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 79, 76, 76).withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 8,
            )
          ],
        ),
        child: Column(
          children: [
            Text(title, style: getStyle(isDone, isCancelled)),
            SpacesHelper.verticalSpace(85),
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
