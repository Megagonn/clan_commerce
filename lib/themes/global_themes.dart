// ignore_for_file: unused_field

import 'package:clan_commerce/utils/size_utils.dart';
import 'package:flutter/material.dart';

abstract class GlobalColors {
  static const primary = Color(0xFF000000);
  static const gray = Color(0xFFf2f3f2);
  static const textLight = Color(0xFFA9A0A0);
  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static const green = Color(0xff1cc464);
  static const red = Color(0xFFef4d4d);
}

abstract class _LightColors {
  static const background = GlobalColors.white;
  static const card = GlobalColors.white;
}

abstract class _DarkColors {
  static const background = Color(0xFF1B1E1F);
  static const card = GlobalColors.primary;
}

/// Reference to the application theme.
abstract class AppTheme {
  static const accentColor = GlobalColors.gray;
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  /// Light theme and its settings.
  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        // colorScheme: ColorScheme.fromSeed(seedColor: GlobalColors.primary),
        useMaterial3: true,
        visualDensity: visualDensity,
        textTheme:  TextTheme(
          displaySmall: TextStyle(
              fontFamily: "Aeonik",
              fontSize: getFontSize(14),
              fontWeight: FontWeight.w400,
              color: GlobalColors.primary),
          displayMedium: TextStyle(
              fontFamily: "Aeonik",
              fontSize: getFontSize(16),
              fontWeight: FontWeight.w500,
              color: GlobalColors.primary),
          displayLarge: TextStyle(
              fontFamily: "Aeonik",
              fontSize: getFontSize(20),
              fontWeight: FontWeight.w700,
              color: GlobalColors.primary),
        ),

        // textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        //   bodyColor: GlobalColors.textDark,
        //   decorationColor: GlobalColors.primary,
        // ),
        scaffoldBackgroundColor: _LightColors.background,
        primarySwatch: Colors.yellow,
        appBarTheme:  AppBarTheme(
            elevation: 0,
            centerTitle: false,
            titleTextStyle:
                TextStyle(fontSize: getFontSize(25), fontWeight: FontWeight.bold),
            foregroundColor: _DarkColors.background,
            backgroundColor: GlobalColors.white),
        cardColor: _LightColors.background,
        primaryTextTheme:  TextTheme(
          // headline6: const TextStyle(color: GlobalColors.textDark),
          displayLarge: TextStyle(
              color: GlobalColors.primary,
              fontSize: getFontSize(20),
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: GlobalColors.primary),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: accentColor,
          primary: GlobalColors.primary,
          background: GlobalColors.white,
        ),
      );

  /// Dark theme and its settings.
  /// Dark theme is not in use for now.
  static ThemeData dark() => ThemeData(
        visualDensity: visualDensity,
        textTheme: const TextTheme(
          displaySmall: TextStyle(
              fontFamily: "Aeonik",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: GlobalColors.white),
          displayMedium: TextStyle(
              fontFamily: "Aeonik",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: GlobalColors.white),
          displayLarge: TextStyle(
              fontFamily: "Aeonik",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: GlobalColors.white),
        ),
        scaffoldBackgroundColor: _DarkColors.background,
        cardColor: _DarkColors.card,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(color: GlobalColors.white),
        ),
        iconTheme: const IconThemeData(color: GlobalColors.white),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
              secondary: accentColor,
            )
            .copyWith(background: _DarkColors.background),
      );

  static TextStyle inputLabelStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
}
