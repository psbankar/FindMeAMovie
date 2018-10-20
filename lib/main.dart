import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';

void main() {
  ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.deepPurpleAccent,
    splashColor: Colors.redAccent,
  );
  return runApp(MaterialApp(
    home: HomePage(),
    theme: themeData,
  ));
}
