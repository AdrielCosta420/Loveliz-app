import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

sealed class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFA6767A),
      secondary: Color(0xffffeef2),
      error: Color(0xffff0000),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.openSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      displayMedium: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      displaySmall: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: const Color(0xff33384B),
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: const Color(0xff33384B),
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        color: const Color(0xffAAB6C3),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xffD9D9D9),
      thickness: 0.5,
      endIndent: 0,
      indent: 0,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFA6767A),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Color(0xFFD9D9D9)),
      backgroundColor: Color(0xFFA6767A),
      
      actionsIconTheme: IconThemeData(color: Color(0xFFD9D9D9)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xB3A6767A),
      selectedItemColor: Colors.white,
      // unselectedItemColor: Color(0xffffeef2),
      unselectedItemColor: Color(0xFFEEEFF2), // Mais suave
      selectedIconTheme: IconThemeData(size: 28), // Ícone maior no selecionado
      unselectedIconTheme: IconThemeData(size: 22), // Ícone menor nos demais
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFA6767A),
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xffFAFAFC),
      shadowColor: Colors.grey,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xffF4F4F6), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
     errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xffF04D00), width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xffF04D00), width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFB2BCC9), width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1, color: Color(0xffF4F4F6)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1, color: Color(0xffF4F4F6)),
          ),
          focusColor: const Color(0xffFAFAFC),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1, color: Color(0xFFA6767A)),
          ),
        ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFA6767A),
      secondary: Color(0xffffeef2),
      error: Color(0xffff0000),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.openSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFA6767A),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xB3A6767A),
      selectedItemColor: Colors.white,
      // unselectedItemColor: Color(0xffffeef2),
      unselectedItemColor: Color(0xFFEEEFF2), // Mais suave
      selectedIconTheme: IconThemeData(size: 28), // Ícone maior no selecionado
      unselectedIconTheme: IconThemeData(size: 22), // Ícone menor nos demais
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF333333),
      shadowColor: Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );
}
