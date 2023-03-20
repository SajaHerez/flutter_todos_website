import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../util/style/appColors.dart';
import '../../util/style/spaces.dart';
import '../../util/style/textStyle.dart';


class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key , required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          text1,
          style: TextStyles.titleStyle,
        ),
        SpacesHelper.horizontalSpace(10),
        GradientText(text2, style: TextStyles.titleStyle, colors: const [
          AppColors.simeblue,
          AppColors.lightGreen,
        ])
      ],
    );
  }
}
