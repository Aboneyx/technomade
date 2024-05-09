import 'package:flutter/material.dart';

class ValidatorUtil {
  ValidatorUtil._();

  static String? defaultValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Required to fill in the field';
    }

    return null;
  }

  static String? passwordValidator(
    BuildContext context,
    String? value, {
    String? repeatPassword,
  }) {
    if (value == null || value.isEmpty) {
      return 'Required to fill in the field';
    }

    if (value.length < 6) {
      return 'The minimum password length is 6 symbols';
    }

    if(value != repeatPassword && repeatPassword != null) {
      return "Passwords don't match";
    }

    return null;
  }
}
