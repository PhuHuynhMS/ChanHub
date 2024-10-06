import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chanhub_colors.dart';

final TextTheme lightTextTheme = TextTheme(
  displayLarge: GoogleFonts.notoSans(
    fontWeight: FontWeight.bold,
    color: ChanHubColors.primary,
  ),
  displayMedium: GoogleFonts.notoSans(
    fontWeight: FontWeight.w700,
    color: ChanHubColors.primary,
  ),
  displaySmall: GoogleFonts.notoSans(
    fontWeight: FontWeight.w600,
    color: ChanHubColors.primary,
  ),
  headlineLarge: GoogleFonts.notoSans(
    fontSize: 40.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.primary,
  ),
  headlineMedium: GoogleFonts.notoSans(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: ChanHubColors.primary,
  ),
  headlineSmall: GoogleFonts.notoSans(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: ChanHubColors.primary,
  ),
  titleLarge: GoogleFonts.notoSans(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.primary,
  ),
  titleMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.primary,
  ),
  titleSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.primary,
  ),
  bodyLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: ChanHubColors.onSurface,
  ),
  bodyMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: ChanHubColors.onSurface,
  ),
  bodySmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: ChanHubColors.onSurface,
  ),
  // displayLarge: GoogleFonts.nabla(
  //   fontSize: 32.0,
  //   fontWeight: FontWeight.bold,
  // ),
  // displayMedium: GoogleFonts.honk(
  //   fontSize: 21.0,
  //   fontWeight: FontWeight.w700,
  // ),
  // displaySmall: GoogleFonts.notoSans(
  //   fontSize: 16.0,
  //   fontWeight: FontWeight.w600,
  // ),
  labelLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: ChanHubColors.onSurface,
  ),
  labelMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: ChanHubColors.onSurface.withOpacity(0.4),
  ),
  labelSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: ChanHubColors.onSurface.withOpacity(0.4),
  ),
);

final TextTheme lightPrimaryTextTheme = TextTheme(
  displayLarge: GoogleFonts.notoSans(
    fontWeight: FontWeight.bold,
    color: ChanHubColors.primary,
  ),
  displayMedium: GoogleFonts.notoSans(
    fontWeight: FontWeight.w700,
    color: ChanHubColors.primary,
  ),
  displaySmall: GoogleFonts.notoSans(
    fontWeight: FontWeight.w600,
    color: ChanHubColors.primary,
  ),
  headlineLarge: GoogleFonts.notoSans(
    fontSize: 40.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.primary,
  ),
  headlineMedium: GoogleFonts.notoSans(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: ChanHubColors.primary,
  ),
  headlineSmall: GoogleFonts.notoSans(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: ChanHubColors.primary,
  ),
  titleLarge: GoogleFonts.notoSans(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.onPrimary,
  ),
  titleMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.onPrimary,
  ),
  titleSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.onPrimary,
  ),
  bodyLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: ChanHubColors.onSurface,
  ),
  bodyMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: ChanHubColors.onSurface,
  ),
  bodySmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: ChanHubColors.onSurface,
  ),
  // displayLarge: GoogleFonts.nabla(
  //   fontSize: 32.0,
  //   fontWeight: FontWeight.bold,
  // ),
  // displayMedium: GoogleFonts.honk(
  //   fontSize: 21.0,
  //   fontWeight: FontWeight.w700,
  // ),
  // displaySmall: GoogleFonts.notoSans(
  //   fontSize: 16.0,
  //   fontWeight: FontWeight.w600,
  // ),
  labelLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: ChanHubColors.onSurface,
  ),
  labelMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: ChanHubColors.onSurface,
  ),
  labelSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: ChanHubColors.onSurface,
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
  primaryTextTheme: lightPrimaryTextTheme,

  // Define the default color of the app.
  appBarTheme: const AppBarTheme(
    foregroundColor: ChanHubColors.onPrimary,
    backgroundColor: ChanHubColors.primary,
    centerTitle: true,
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
  dividerTheme: DividerThemeData(
    color: lightColorScheme.primary.withOpacity(0.3),
    thickness: 1.0,
    space: 0.0,
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
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(ChanHubColors.primary),
      foregroundColor: WidgetStatePropertyAll(ChanHubColors.onPrimary),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: ChanHubColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
  ),
);
