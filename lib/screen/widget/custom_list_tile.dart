import 'package:flutter/material.dart';

import '../../util/style/appColors.dart';
import '../../util/style/spaces.dart';
import '../../util/style/textStyle.dart';

// class CustomListTile extends StatelessWidget {
//   CustomListTile(
//       {super.key,
//       required this.title,
//       required this.rightOnTap,
//       required this.leftOnTap});
//   final String title;
//   void Function()? rightOnTap;
//   void Function()? leftOnTap;
//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       endActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         extentRatio: .3,
//         children: [
//           ScaleButtom(
//             color: AppColors.simeRed,
//             onTap: rightOnTap,
//             icon: Icons.delete,
//           )
//         ],
//       ),
//       startActionPane: ActionPane(
//         extentRatio: .25,
//         motion: const ScrollMotion(),
//         children: [
//           ScaleButtom(
//             color: AppColors.simeGreen,
//             onTap: leftOnTap,
//             icon: Icons.edit,
//             margin: const EdgeInsets.only(right: 10),
//           )
//         ],
//       ),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//         margin: const EdgeInsets.only(bottom: 15),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             gradient: const LinearGradient(
//               begin: Alignment.centerRight,
//               end: Alignment.centerLeft,
//               colors: [
//                 AppColors.simegreen2,
//                 AppColors.simeblue2,
//               ],
//             )),
//         child: ListTile(title: Text(title, style: TextStyles.titleStyle3)),
//       ),
//     );
//   }
// }

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key,
      required this.title,
      required this.rightOnTap,
      required this.leftOnTap});
  final String title;
  void Function()? rightOnTap;
  void Function()? leftOnTap;
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
            Text(title, style: TextStyles.titleStyle3),
            SpacesHelper.verticalSpace(100),
            ButtonBar(
              children: [
                GestureDetector(
                  onTap: leftOnTap,
                  child: const Icon(
                    Icons.edit,
                  ),
                ),
                SpacesHelper.verticalSpace(15),
                GestureDetector(
                  onTap: rightOnTap,
                  child: const Icon(
                    Icons.delete,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
