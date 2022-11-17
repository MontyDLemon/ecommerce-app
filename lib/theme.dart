import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue,
        typography: Typography.material2018(),
        backgroundColor: const Color(0xffF5F5F5),
        appBarTheme: const AppBarTheme(
            elevation: 0.0,
            backgroundColor: Color(0xffF5F5F5),
            iconTheme: IconThemeData(
              color: Color(0xff525252),
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: Color(0xffD6D6D6),
          selectedItemColor: AppColor.buttonColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              AppColor.buttonColor,
            ),
            shape: MaterialStateProperty.all(const StadiumBorder()),
          ),
        ),
      );
}

extension AppColor on Colors {
  static const buttonColor = Color(0xFF75B6F0);
  static const lightColor = Color(0xffA3CEF5);
  static const textColor = Color(0XFF333333);
}
