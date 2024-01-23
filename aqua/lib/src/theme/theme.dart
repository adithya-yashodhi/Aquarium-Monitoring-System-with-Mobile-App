import 'package:aqua/src/theme/widgets_theme/elevated_button_theme.dart';
import 'package:aqua/src/theme/widgets_theme/outlined_button_theme.dart';
import 'package:aqua/src/theme/widgets_theme/text_field_theme.dart';
import 'package:aqua/src/theme/widgets_theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {

  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TTextTheme.lightTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme
  );
}