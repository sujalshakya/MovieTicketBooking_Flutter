import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData.dark().copyWith(
  canvasColor: hexStringToColor("121111"),
  scaffoldBackgroundColor: hexStringToColor("121111"),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    unselectedItemColor: hexStringToColor("6E6D63"),
    selectedItemColor: hexStringToColor("2B2B26"),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    type: BottomNavigationBarType.shifting,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: hexStringToColor("121111"),
    iconTheme: const IconThemeData(color: Colors.white),
    actionsIconTheme: const IconThemeData(size: 30),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: hexStringToColor("121111"),
    linearTrackColor: hexStringToColor("121111"),
  ),
  iconTheme: IconThemeData(color: hexStringToColor("2B2B26")),
  buttonTheme: ButtonThemeData(
    buttonColor: hexStringToColor("F0F0F0"),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(hexStringToColor("121111")),
      backgroundColor:
          MaterialStateProperty.all<Color>(hexStringToColor("F0F0F0")),
    ),
  ),
);

Color hexStringToColor(String hexString) {
  return Color(int.parse(hexString, radix: 16) + 0xFF000000);
}
