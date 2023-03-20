import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todos_website/util/style/appColors.dart';

import '../../util/constant/pathes.dart';
import '../../util/routing/RouterNamed.dart';
import '../../util/routing/RoutingUilites.dart';
import '../../util/style/spaces.dart';
import '../../util/style/textStyle.dart';
import '../../util/validation/validation.dart';
import '../widget/customButton.dart';
import '../widget/customTextField.dart';
import '../widget/customTitle.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 450,
            height: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 67, 64, 64)),
            padding: const EdgeInsets.only(right: 25, left: 25, top: 20),
            child: Form(
              child: Column(
                children: [
                  const CustomTitle(text1: "Sign", text2: "Up"),
                  Text(
                    "Create a new account!",
                    style: TextStyles.titleStyle2,
                  ),
                  SpacesHelper.verticalSpace(20),
                  CustomTextField(
                    hintText: "Full name",
                    path: "${Pathes.iconPath}Profile${Extension.png}",
                    validator: Validation.nameValidation,
                    controller: TextEditingController(),
                  ),
                  SpacesHelper.verticalSpace(10),
                  CustomTextField(
                    hintText: "Email",
                    path: "${Pathes.iconPath}email1${Extension.png}",
                    validator: Validation.emailValidation,
                    controller: TextEditingController(),
                  ),
                  SpacesHelper.verticalSpace(10),
                  CustomTextField(
                      hintText: "Password",
                      path: "${Pathes.iconPath}Lock${Extension.png}",
                      validator: Validation.passwordValidation,
                      controller: TextEditingController()),
                  SpacesHelper.verticalSpace(30),
                  CustomButton(
                    text: "Sign Up",
                    onPressed: () {
                      RoutingUtil.push(RouterName.homeScreen);
                    },
                  ),
                  SpacesHelper.verticalSpace(20),
                  Wrap(
                    children: [
                      Text(
                        "Have an account?",
                        style: TextStyles.hintTextStyle1,
                      ),
                      GestureDetector(
                        onTap: () {
                          RoutingUtil.push(RouterName.loginScreen);
                        },
                        child: Text(
                          " Log In",
                          style: TextStyles.hintTextStyle2,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
