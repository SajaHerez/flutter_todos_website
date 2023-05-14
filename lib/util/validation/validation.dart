import 'package:flutter/material.dart';
import 'reg_exp.dart';

class Validation {
 static String? passwordValidation(String? password) {
    if (password!.isEmpty) {
      return "Enter The Password";
    }
    if (!passReg.hasMatch(password)) {
      return "Enter Valid Password,at least 8 characters";
    }
    return null;
  }

 static String? emailValidation(String? email) {
    if (email!.isEmpty) {
      return "Enter The Email";
    }
    if (!emailReg.hasMatch(email)) {
      return "Enter Valid Email(example@gmail.com)";
    }
    return null;
  }

 static String? nameValidation(String? name) {
    if (name!.isEmpty) {
      return "Enter The Name";
    }
    if (!nameReg.hasMatch(name)) {
      return "Enter Valid Name(Jhon Alex)";
    }
    return null;
  }

 static  bool validateForm(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    return form!.validate() ? true : false;
  }
}
