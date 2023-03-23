import 'package:flutter/material.dart';

import '../../util/style/appColors.dart';
import '../../util/style/textStyle.dart';

Future<void> showAlertDialog(BuildContext context,
    {required void Function()? onPressed}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        buttonPadding: const EdgeInsets.only(right: 80),
     //   actionsPadding: const EdgeInsets.only(left: 50, right: 60),
        titlePadding: const EdgeInsets.only(top: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.simeBlack,
        title: const Icon(
          Icons.info,
          color: AppColors.midGray2,
          size: 28,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        content: Text(
          "Are your sure you want Delete this Note ?",
          textAlign: TextAlign.center,
          style: TextStyles.dialogTitleStyle,
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 40),
              backgroundColor: AppColors.lightGray2,
            ),
            child: Text(
              'Cancel',
              style: TextStyles.btnTextStyle2,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 40),
              backgroundColor: AppColors.simeRed,
            ),
            onPressed: onPressed,
            child: Text(
              'Delete',
              style: TextStyles.btnTextStyle2,
            ),
          ),
        ],
      );
    },
  );
}
