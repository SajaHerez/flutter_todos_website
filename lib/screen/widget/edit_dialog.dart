import 'package:flutter/material.dart';

import '../../util/style/appColors.dart';
import '../../util/style/textStyle.dart';

Future<void> showEditDialog(BuildContext context,
    {required void Function()? onPressed,
    required TextEditingController controller,
    required String title,
    required String actionName}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        buttonPadding: const EdgeInsets.only(right: 80),
        titlePadding: const EdgeInsets.only(top: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.simeBlack,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.dialogTitleStyle,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        content: SizedBox(
          width: 400,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              hintText: 'Type something...',
              hintStyle: TextStyles.descriptionTextStyle,
              filled: true,
              fillColor: AppColors.darkGray,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
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
              actionName,
              style: TextStyles.btnTextStyle2,
            ),
          ),
        ],
      );
    },
  );
}
