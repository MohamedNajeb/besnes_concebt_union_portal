import 'package:flutter/material.dart';
import 'package:unionportal/AppTheme.dart';

import '../SizeConfig.dart';

class Styling {
  Styling._();

  static final TextStyle txtThemeSize2buttonsColor = TextStyle(
    color: AppTheme.buttonsColor,
    fontSize: 2 * SizeConfig.textMultiplier,
    fontFamily: "Cairo",
  );

  static final TextStyle txtThemeSize2Bold = TextStyle(
    color: AppTheme.titleTextColor,
    fontWeight: FontWeight.bold,
    fontSize: 2.5 * SizeConfig.textMultiplier,
    fontFamily: "Cairo",
  );

  static final TextStyle txtThemeSize2Bold2 = TextStyle(
    color: AppTheme.titleTextColor,
    fontWeight: FontWeight.bold,
    fontSize: 2 * SizeConfig.textMultiplier,
    fontFamily: "Cairo",
  );

  static  final TextStyle txtThemeSize2BoldOrangeColor = TextStyle(
    fontSize: 2 * SizeConfig.textMultiplier,
    color: AppTheme.textOrangeColor,
    fontWeight: FontWeight.bold,
    fontFamily: "Cairo",
  );

  static final TextStyle txtThemeWhiteSizeW600 = TextStyle(
    fontSize: 1.7 * SizeConfig.textMultiplier,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: "Cairo",
  );

  static final TextStyle txtTheme16 = TextStyle(
    fontSize: 16,
    color: AppTheme.appBackgroundColor,
    fontFamily: "Cairo",
  );

  static final TextStyle txtTheme14 = TextStyle(
    fontSize: 14,
    color: AppTheme.appBackgroundColor,
    fontFamily: "Cairo",
    fontWeight: FontWeight.w600,
  );

  static final TextStyle txtTheme20 = TextStyle(
    color: AppTheme.appBackgroundColor,
    fontSize: 20.0,
    fontFamily: "Cairo",
    letterSpacing: 1.5,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle txtTheme = TextStyle(
    color: AppTheme.itemColor,
    fontFamily: "Cairo",
  );

  static final TextStyle txtTheme20BackgroundColor = TextStyle(
    color: AppTheme.appBackgroundColor,
    fontSize: 20.0,
    fontFamily: "Cairo",
    letterSpacing: 1.5,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle txtTheme20GradientColor1 = TextStyle(
    color: AppTheme.buttonsGradientColor1,
    fontSize: 20.0,
    fontFamily: "Cairo",
  );

  static final TextStyle txtTheme18bold = TextStyle(
    fontSize: 18.0,
    fontFamily: "Cairo",
    fontWeight: FontWeight.bold,
    color: AppTheme.titleTextColor,
  );

  static final TextStyle txtTheme12w600 = TextStyle(
    fontSize: 12.0,
    fontFamily: "Cairo",
    fontWeight: FontWeight.w600,
    color: AppTheme.subTitleTextColor,
  );

  static final TextStyle txtTheme16w600 = TextStyle(
    color: AppTheme.buttonsGradientColor1,
    fontSize: 16.0,
    fontFamily: "Cairo",
    fontWeight: FontWeight.w600,
  );

  static final TextStyle txtTheme12w600GradientColor2 = TextStyle(
    color: AppTheme.buttonsGradientColor2,
    fontSize: 12.0,
    fontFamily: "Cairo",
    fontWeight: FontWeight.w600,
  );

  static final TextStyle txtTheme20bold = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Cairo",
    fontWeight: FontWeight.bold,
  );

  static final TextStyle errorTxtTheme = TextStyle(
    color: AppTheme.backGround,
    fontSize: 2.5 * SizeConfig.textMultiplier,
    fontFamily: "Cairo",
    fontWeight: FontWeight.bold,
  );

  static final TextStyle txtTheme18w900 = TextStyle(
    fontSize: 18,
    fontFamily: "Cairo",
    fontWeight: FontWeight.w900,
    color: Colors.white,
  );

  static final TextStyle txtTheme16black = TextStyle(
      fontFamily: "Cairo",
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static final TextStyle txtTheme18blackbold = TextStyle(
      fontFamily: "Cairo",
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static final TextStyle txtTheme20n = TextStyle(
    color: AppTheme.appBackgroundColor,
    fontSize: 20.0,
    fontFamily: "Cairo",
  );
}
