import 'package:flutter/material.dart';

import '../../util/style/appColors.dart';
import '../../util/style/textStyle.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      this.path,
      this.keyboardType = TextInputType.text,
      required this.validator,
      required this.controller});
  final String hintText;
  final bool obscureText;

  final String? path;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 67, 64, 64),
      elevation: 2,
      shadowColor: const Color.fromARGB(255, 67, 64, 64).withOpacity(.25),
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        style: TextStyles.hintTextStyle1,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelStyle: TextStyles.hintTextStyle1,
          errorStyle: TextStyles.errorTextStyle2,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.simeGreen)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.simeGreen)),
          filled: true,
          fillColor: AppColors.darkGray,
          focusColor: AppColors.simeGreen,
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          hintStyle: TextStyles.hintTextStyle1,
          //  contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          prefixIcon: path != null
              ? ImageIcon(
                  AssetImage(path!),
                  color: AppColors.simeGreen,
                  size: 24,
                )
              : null,
        ),
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
      ),
    );
  }
}
