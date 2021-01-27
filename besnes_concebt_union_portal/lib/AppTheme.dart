import 'package:flutter/material.dart';

import 'SizeConfig.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Color(0xFFFFFFFF);

  static const Color colorPrimary = Color(0xFF1660A9);
  static const Color colorPrimaryB = Color(0xFFEFF2FB);
  static const Color gg = Color(0xff94aaac);
  static const Color black = Color(0xff20262C);

  static const Color itemColor = Color(0xFFF8FAFB);
  static const Color lightGrey = Color(0xffE1E2E4);
  static const Color liteGray = Color(0xff50576A);
  static const Color colorI = Color(0xFFa9cff4);
  static const Color backGround = Color(0xfff0f0f0);
  static const Color whitGround = Color(0xFFF4F4F4);

  static const Color titleTextColor = const Color(0xFF1d2635);
  static const Color subTitleTextColor = const Color(0xFF797878);

  static const Color buttonsColor = const Color(0xFF2c3e50);
  static const Color buttonsTextColor = const Color(0xFFFFFEFD);

  static const Color textOrangeColor = const Color(0xFFc05555);
  // static const Color textOrangeColor = const Color(0xFFaa3a3a);

  static const Color buttonsGradientColor1 = const Color(0xFFc05555);
  //static const Color buttonsGradientColor1 = const Color(0xFFaa3a3a);
  static const Color buttonsGradientColor2 = const Color(0xFFEB4960);

  static const Color hintColor = const Color(0xff505A76);

  static const Color primary = Color(0xff696b9e);
  static const Color secondary = Color(0xfff29a94);

  static final titleTextTheme = TextStyle(
    fontSize: 2 * SizeConfig.textMultiplier,
    color: black,
    fontFamily: "Cairo",
  );

  static final titleTextWightTheme = TextStyle(
    fontSize: 2 * SizeConfig.textMultiplier,
    color: appBackgroundColor,
    fontFamily: "Cairo",
  );

  static final subTitleTextWightTheme = TextStyle(
    fontSize: 1.5 * SizeConfig.textMultiplier,
    color: itemColor,
    fontFamily: "Cairo",
  );

  static final TextStyle subTitleTheme = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 1.7 * SizeConfig.textMultiplier,
    fontFamily: "Cairo",
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    brightness: Brightness.light,
    fontFamily: "Cairo",
    appBarTheme: AppBarTheme(color: buttonsColor),
  );

//  static final ThemeData darkTheme = ThemeData(
//    scaffoldBackgroundColor: Colors.black,
//    brightness: Brightness.dark,
//    textTheme: darkTextTheme,
//  );

//  static final TextTheme lightTextTheme = TextTheme(
//    title: _titleLight,
//    subtitle: _subTitleLight,
//    button: _buttonLight,
//    display1: _dateText,
//    display2: _searchLight,
//    body1: _selectedTabLight,
//    body2: _unSelectedTabLight,
//  );
//
//  static final TextTheme darkTextTheme = TextTheme(
//    title: _titleDark,
//    subtitle: _subTitleDark,
//    button: _buttonDark,
//    display1: _greetingDark,
//    display2: _searchDark,
//    body1: _selectedTabDark,
//    body2: _unSelectedTabDark,
//  );

//  static final TextStyle _titleLight = TextStyle(
//    color: Color(0xFF165FA9),
//    // 0xFF165FA9
//    fontWeight: FontWeight.bold,
//    fontSize: 2 * SizeConfig.textMultiplier,
//  );
//
//  static final TextStyle _subTitleLight = TextStyle(
//    color: Color(0xFF000000),
//    fontWeight: FontWeight.bold,
//    fontSize: 2.0 * SizeConfig.textMultiplier,
//  );
//
//  static final TextStyle _buttonLight = TextStyle(
//    color: Colors.black,
//    fontSize: 2.5 * SizeConfig.textMultiplier,
//  );
//
//  static final TextStyle _dateText = TextStyle(
//    color: Color(0xFF000000),
//    fontWeight: FontWeight.normal,
//    fontSize: 2 * SizeConfig.textMultiplier,
//  );

//  static final TextStyle _searchLight = TextStyle(
//    color: Colors.black,
//    fontSize: 2.3 * SizeConfig.textMultiplier,
//  );
//
//  static final TextStyle _selectedTabLight = TextStyle(
//      color: Color(0xFF184923),
//      fontWeight: FontWeight.bold,
//      fontSize: 2.0 * SizeConfig.textMultiplier,
//      fontFamily: "Newfont");
//
//  static final TextStyle _unSelectedTabLight = TextStyle(
//    color: Colors.grey,
//    fontSize: 2 * SizeConfig.textMultiplier,
//  );
//
//  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);
//
//  static final TextStyle _subTitleDark =
//      _subTitleLight.copyWith(color: Colors.white70);
//
//  static final TextStyle _buttonDark =
//      _buttonLight.copyWith(color: Colors.black);
//
//  static final TextStyle _greetingDark =
//      _dateText.copyWith(color: Colors.black);

  static final TextStyle _searchDark =
      _searchDark.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark =
      _selectedTabDark.copyWith(color: Colors.white);

//  static final TextStyle _unSelectedTabDark =
//      _selectedTabDark.copyWith(color: Colors.white70);
}
