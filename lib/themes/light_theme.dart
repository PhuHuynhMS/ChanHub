import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chanhub_colors.dart';

final TextTheme lightTextTheme = TextTheme(
  titleLarge: GoogleFonts.notoSans(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  ),
  titleMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
  ),
  titleSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  ),
  bodyLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  ),
  bodySmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  ),
  displayLarge: GoogleFonts.nabla(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  ),
  displayMedium: GoogleFonts.honk(
    fontSize: 21.0,
    fontWeight: FontWeight.w700,
  ),
  displaySmall: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  ),
  labelLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  ),
  labelMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  ),
  labelSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  ),
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: ChanHubColors.primary,
  onPrimary: ChanHubColors.onPrimary,
  secondary: ChanHubColors.secondary,
  onSecondary: ChanHubColors.onSecondary,
  tertiary: ChanHubColors.tertiary,
  onTertiary: ChanHubColors.onTertiary,
  error: ChanHubColors.error,
  onError: ChanHubColors.onError,
  surface: ChanHubColors.surface,
  onSurface: ChanHubColors.onSurface,
);

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  splashColor: Colors.white,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: lightTextTheme,

  // Define the default color of the app.
  appBarTheme: AppBarTheme(
    foregroundColor: ChanHubColors.onPrimary,
    backgroundColor: ChanHubColors.primary,
    titleTextStyle: lightTextTheme.titleLarge,
    centerTitle: true,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: ChanHubColors.onPrimary,
    backgroundColor: ChanHubColors.primary,
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(color: ChanHubColors.primary);
      }
      return const TextStyle(color: ChanHubColors.secondary);
    }),
    iconTheme: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: ChanHubColors.primary);
        }
        return const IconThemeData(color: ChanHubColors.secondary);
      },
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: ChanHubColors.surface,
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: lightTextTheme.bodyMedium,
    selectedColor: ChanHubColors.tertiary,
    iconColor: ChanHubColors.primary,
    textColor: ChanHubColors.primary,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
    dense: true,
  ),
  // dividerColor: ChanHubColors.onSurface.withOpacity(0.3));
);
