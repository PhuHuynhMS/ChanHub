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
    color: ChanHubColors.onPrimary,
  ),
  displayMedium: GoogleFonts.notoSans(
    fontWeight: FontWeight.w700,
    color: ChanHubColors.onPrimary,
  ),
  displaySmall: GoogleFonts.notoSans(
    fontWeight: FontWeight.w600,
    color: ChanHubColors.onPrimary,
  ),
  headlineLarge: GoogleFonts.notoSans(
    fontSize: 40.0,
    fontWeight: FontWeight.w600,
    color: ChanHubColors.onPrimary,
  ),
  headlineMedium: GoogleFonts.notoSans(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: ChanHubColors.onPrimary,
  ),
  headlineSmall: GoogleFonts.notoSans(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: ChanHubColors.onPrimary,
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

  // IconThemeData
  iconTheme: const IconThemeData(color: ChanHubColors.primary),
  primaryIconTheme: const IconThemeData(color: ChanHubColors.onPrimary),

  // Scaffold
  appBarTheme: const AppBarTheme(
    foregroundColor: ChanHubColors.onPrimary,
    backgroundColor: ChanHubColors.primary,
    centerTitle: false,
    iconTheme: IconThemeData(color: ChanHubColors.onPrimary),
    actionsIconTheme: IconThemeData(color: ChanHubColors.onPrimary),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: ChanHubColors.surface,
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
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: ChanHubColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: ChanHubColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    insetPadding: EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 20.0,
    ),
  ),

  // ButtonThemeData
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return lightColorScheme.primary.withOpacity(0.4);
          }
          return lightColorScheme.primary;
        },
      ),
      foregroundColor: WidgetStatePropertyAll(lightColorScheme.onPrimary),
      textStyle: WidgetStatePropertyAll(lightTextTheme.titleMedium),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(lightColorScheme.primary),
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(lightTextTheme.titleMedium),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: lightTextTheme.labelMedium,
      floatingLabelStyle: lightTextTheme.titleMedium,
      labelStyle: lightTextTheme.labelMedium,
      prefixIconColor: ChanHubColors.primary,
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      side: WidgetStatePropertyAll(BorderSide.none),
    ),
  ),

  // InputDecorationTheme
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: lightTextTheme.labelMedium,
    floatingLabelStyle: lightTextTheme.titleMedium,
    labelStyle: lightTextTheme.labelMedium,
    prefixIconColor: ChanHubColors.primary,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ChanHubColors.primary;
        }
        return ChanHubColors.tertiary;
      },
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return ChanHubColors.primary.withOpacity(0.1);
        }
        return ChanHubColors.primary.withOpacity(0.1);
      },
    ),
    trackColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ChanHubColors.primary.withOpacity(0.3);
        }
        return ChanHubColors.tertiary.withOpacity(0.3);
      },
    ),
  ),

  // CardTheme
  cardTheme: CardTheme(
    color: ChanHubColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),

  // Other
  listTileTheme: ListTileThemeData(
    titleTextStyle: lightTextTheme.bodyMedium,
    selectedColor: ChanHubColors.tertiary,
    iconColor: ChanHubColors.primary,
    textColor: ChanHubColors.onSurface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
    dense: true,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    backgroundColor: ChanHubColors.surface,
    iconColor: ChanHubColors.primary,
    collapsedIconColor: ChanHubColors.primary,
    textColor: ChanHubColors.onSurface,
    shape: Border(),
  ),
  dividerTheme: DividerThemeData(
    color: lightColorScheme.primary.withOpacity(0.3),
    thickness: 1.0,
    space: 0.0,
  ),
);
