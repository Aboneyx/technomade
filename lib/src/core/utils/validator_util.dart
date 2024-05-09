import 'package:flutter/material.dart';

class ValidatorUtil {
  ValidatorUtil._();

  static String? defaultValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Required to fill in the field';
    }

    return null;
  }
}
