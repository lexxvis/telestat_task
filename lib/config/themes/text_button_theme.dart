import 'package:flutter/material.dart';

import '../../utils/colors/app_colors.dart';


var textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.pressed)) {
      return AppColors.buttonPressed;
    }
    if (states.contains(MaterialState.disabled)) {
      return AppColors.buttonInactive;
    }
    if (states.contains(MaterialState.hovered)) {
      return AppColors.buttonHover;
    }
    return AppColors.buttonActive;
  }),
  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  )),
));
