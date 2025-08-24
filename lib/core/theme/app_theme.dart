import 'package:flutter/material.dart';
import 'package:playo/core/theme/wolt_modal_theme_config.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF4CBB17), // Color(0xFF0077B3),
    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    brightness: Brightness.light,
  ),
  extensions: <ThemeExtension>[WoltModalThemeConfig.lightTheme()],
  // fontFamily: 'Poppins',
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF4CBB17), //Color(0xFF0077B3),
    dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
    brightness: Brightness.dark,
  ),
  extensions: <ThemeExtension>[WoltModalThemeConfig.darkTheme()],
  // fontFamily: 'Poppins',
);
