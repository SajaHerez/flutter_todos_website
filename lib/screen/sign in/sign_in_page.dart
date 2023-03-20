import 'package:flutter/material.dart';
import '../../util/constant/pathes.dart';
import '../../util/routing/RouterNamed.dart';
import '../../util/routing/RoutingUilites.dart';
import '../../util/style/spaces.dart';
import '../../util/style/textStyle.dart';
import '../../util/validation/validation.dart';
import '../widget/customButton.dart';
import '../widget/customTextField.dart';
import '../widget/customTitle.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 450,
          height: 480,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 67, 64, 64)),
          padding: const EdgeInsets.only(right: 25, left: 25, top: 35),
          child: Form(
            child: Column(
              children: [
                const CustomTitle(text1: "Sign", text2: "In"),
                SpacesHelper.verticalSpace(45),
                CustomTextField(
                  hintText: "example@gmail.com",
                  path: "${Pathes.iconPath}Profile${Extension.png}",
                  validator: Validation.emailValidation,
                  controller: TextEditingController(),
                ),
                SpacesHelper.verticalSpace(14),
                CustomTextField(
                  hintText: "Password",
                  path: "${Pathes.iconPath}Lock${Extension.png}",
                  validator: Validation.passwordValidation,
                  controller: TextEditingController(),
                ),
                SpacesHelper.verticalSpace(45),
                CustomButton(
                  text: "Login",
                  onPressed: () async {
                    RoutingUtil.push(RouterName.homeScreen);
                  },
                ),
                SpacesHelper.verticalSpace(45),
                Wrap(
                  children: [
                    Text(
                      "Have an account?",
                      style: TextStyles.hintTextStyle1,
                    ),
                    GestureDetector(
                        onTap: () {
                          RoutingUtil.push(RouterName.signUpScreen);
                        },
                        child: Text(
                          " Sign Up",
                          style: TextStyles.hintStyleWithUnderline,
                        ))
                  ],
                ),
                SpacesHelper.verticalSpace(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
