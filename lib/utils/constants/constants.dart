import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

const roundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
);

const grayFontStyle = TextStyle(fontSize: 14, color: Colors.grey);
const blackFontStyle =
    TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);

const buttonTextStyle = TextStyle(fontSize: 16, color: AppColors.buttonText);
