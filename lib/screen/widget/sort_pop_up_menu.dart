import 'package:flutter/material.dart';

import '../../util/style/appColors.dart';

class SortMenue extends StatelessWidget {
  SortMenue(
      {super.key,
      required this.sortOnCompletedDate,
      required this.sortOnCreatedDate});
  void Function() sortOnCompletedDate;
  void Function() sortOnCreatedDate;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.import_export,
        size: 35,
        color: AppColors.white,
      ),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: 'created',
            child: Text('Date Created'),
          ),
          const PopupMenuItem(
            value: 'completed',
            child: Text('Date Completed'),
          ),
        ];
      },
      onSelected: (String value) {
        if (value == 'created') {
          sortOnCreatedDate();
        } else if (value == 'completed') {
          sortOnCompletedDate();
        }
      },
    );
  }
}
