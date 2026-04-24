import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/SizeConfig.dart';

class AppTheme {
  AppTheme._();

  /*
  ---------------- LIGHT COLORS ----------------
  */

  static const Color _lightIconColor = Colors.grey;
  static final Color _lightPrimaryColor = Colors.green.shade700;
  static final Color _lightPrimaryVariantColor = Colors.green.shade900;
  static const Color _lightSecondaryColor = Colors.grey;
  static const Color _lightOnPrimaryColor = Colors.yellowAccent;
  static const Color _lightPrimaryIconThemeColor = Colors.white;
  static const Color _lightButtonTextColor = Colors.white;
  static const Color _lightButtonColor = Colors.deepPurple;
  static const Color _lightDividerColor = Colors.black;
  static final Color _lightCardColor = Colors.green.shade900;
  static const Color _lightShadowColor = Colors.grey;

  /*
  ---------------- DARK COLORS ----------------
  */

  static const Color _darkPrimaryColor = Colors.black;
  static final Color _darkPrimaryVariantColor = Colors.grey.shade800;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkIconColor = Colors.white;
  static const Color _darkPrimaryIconThemeColor = Colors.red;
  static const Color _darkButtonColor = Colors.red;
  static const Color _darkButtonTextColor = Colors.white;
  static const Color _darkDividerColor = Colors.white;
  static const Color _darkCardColor = Colors.grey;
  static const Color _darkShadowColor = Colors.white70;

  /*
  ---------------- LIGHT THEME ----------------
  */

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: _lightPrimaryColor,

    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),

    canvasColor: _lightPrimaryColor,

    iconTheme: const IconThemeData(color: _lightIconColor),
    primaryIconTheme: const IconThemeData(color: _lightPrimaryIconThemeColor),

    dividerColor: _lightDividerColor,

    textTheme: _lightTextTheme,

    appBarTheme: AppBarTheme(
      backgroundColor: _lightPrimaryVariantColor,
      elevation: 8,
      iconTheme: const IconThemeData(color: _lightPrimaryIconThemeColor),
      titleTextStyle: GoogleFonts.flavors(
        fontSize: 3.12 * SizeConfig.textMultiplier,
        color: _lightOnPrimaryColor,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 6,
      color: _lightCardColor,
      shadowColor: _lightShadowColor,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightButtonColor,
        foregroundColor: _lightButtonTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: TextStyle(
          fontSize: 1.56 * SizeConfig.textMultiplier,
        ),
      ),
    ),

    inputDecorationTheme: _lightInputDecorationTheme,
  );

  /*
  ---------------- DARK THEME ----------------
  */

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: _darkPrimaryColor,

    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
    ),

    canvasColor: _darkPrimaryColor,

    iconTheme: const IconThemeData(color: _darkIconColor),
    primaryIconTheme: const IconThemeData(color: _darkPrimaryIconThemeColor),

    dividerColor: _darkDividerColor,

    textTheme: _darkTextTheme,

    appBarTheme: AppBarTheme(
      backgroundColor: _darkPrimaryVariantColor,
      elevation: 8,
      iconTheme: const IconThemeData(color: _darkOnPrimaryColor),
      titleTextStyle: GoogleFonts.lobster(
        fontSize: 3.12 * SizeConfig.textMultiplier,
        color: _darkOnPrimaryColor,
      ),
    ),

    cardTheme: const CardThemeData(
      elevation: 6,
      color: _darkCardColor,
      shadowColor: _darkShadowColor,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkButtonColor,
        foregroundColor: _darkButtonTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),

    inputDecorationTheme: _darkInputDecorationTheme,
  );

  /*
  ---------------- INPUT DECORATION ----------------
  */

  static final InputDecorationTheme _lightInputDecorationTheme =
      InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _lightPrimaryVariantColor),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _lightPrimaryVariantColor),
    ),
    hintStyle: GoogleFonts.ptSans(textStyle: _lightBodyStyle),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );

  static final InputDecorationTheme _darkInputDecorationTheme =
      InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _darkPrimaryVariantColor),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _darkPrimaryVariantColor),
    ),
    hintStyle: GoogleFonts.ptSans(textStyle: _darkBodyStyle),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );

  /*
  ---------------- TEXT THEMES ----------------
  */

  static final TextTheme _lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.flavors(textStyle: _lightHeadingStyle),
    bodyLarge: GoogleFonts.ptSans(textStyle: _lightBodyStyle),
    bodyMedium: GoogleFonts.ptSans(textStyle: _lightBody2Style),
    titleMedium: GoogleFonts.ptSans(textStyle: _lightSubtitleStyle),
    titleSmall: GoogleFonts.ptSans(textStyle: _lightSubtitle2Style),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.oswald(textStyle: _darkHeadingStyle),
    bodyLarge: GoogleFonts.ptSans(textStyle: _darkBodyStyle),
    titleMedium: GoogleFonts.ptSans(textStyle: _darkSubtitleStyle),
    titleSmall: GoogleFonts.ptSans(textStyle: _darkSubtitle2Style),
  );

  /*
  ---------------- TEXT STYLES ----------------
  */

  static final TextStyle _lightHeadingStyle = TextStyle(
    fontSize: 3.12 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.normal,
    color: _lightOnPrimaryColor,
    letterSpacing: 1.4,
  );

  static final TextStyle _lightBodyStyle = TextStyle(
    fontSize: 2.23 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
  );

  static final TextStyle _lightBody2Style = TextStyle(
    fontSize: 2 * SizeConfig.textMultiplier,
    color: _lightPrimaryColor,
  );

  static final TextStyle _lightSubtitleStyle = TextStyle(
    fontSize: 1.79 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
  );

  static final TextStyle _lightSubtitle2Style = TextStyle(
    fontSize: 1.60 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
  );

  static final TextStyle _darkHeadingStyle =
      _lightHeadingStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkBodyStyle =
      _lightBodyStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkSubtitleStyle =
      _lightSubtitleStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkSubtitle2Style =
      _lightSubtitle2Style.copyWith(color: _darkOnPrimaryColor);

  /*
  ---------------- UTIL ----------------
  */

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}