import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chanhub_dark_colors.dart';

final TextTheme darkTextTheme = TextTheme(
  displayLarge: GoogleFonts.notoSans(
    fontWeight: FontWeight.bold,
    color: ChanHubDarkColors.primary,
  ),
  displayMedium: GoogleFonts.notoSans(
    fontWeight: FontWeight.w700,
    color: ChanHubDarkColors.primary,
  ),
  displaySmall: GoogleFonts.notoSans(
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.primary,
  ),
  headlineLarge: GoogleFonts.notoSans(
    fontSize: 40.0,
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.primary,
  ),
  headlineMedium: GoogleFonts.notoSans(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: ChanHubDarkColors.primary,
  ),
  headlineSmall: GoogleFonts.notoSans(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: ChanHubDarkColors.primary,
  ),
  titleLarge: GoogleFonts.notoSans(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.primary,
  ),
  titleMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.primary,
  ),
  titleSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.primary,
  ),
  bodyLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: ChanHubDarkColors.onSurface,
  ),
  bodyMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: ChanHubDarkColors.onSurface,
  ),
  bodySmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: ChanHubDarkColors.onSurface,
  ),
  labelLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: ChanHubDarkColors.onSurface,
  ),
  labelMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: ChanHubDarkColors.onSurface.withOpacity(0.4),
  ),
  labelSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: ChanHubDarkColors.onSurface.withOpacity(0.4),
  ),
);

final TextTheme darkPrimaryTextTheme = TextTheme(
  displayLarge: GoogleFonts.notoSans(
    fontWeight: FontWeight.bold,
    color: ChanHubDarkColors.onPrimary,
  ),
  displayMedium: GoogleFonts.notoSans(
    fontWeight: FontWeight.w700,
    color: ChanHubDarkColors.onPrimary,
  ),
  displaySmall: GoogleFonts.notoSans(
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.onPrimary,
  ),
  headlineLarge: GoogleFonts.notoSans(
    fontSize: 40.0,
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.onPrimary,
  ),
  headlineMedium: GoogleFonts.notoSans(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: ChanHubDarkColors.onPrimary,
  ),
  headlineSmall: GoogleFonts.notoSans(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: ChanHubDarkColors.onPrimary,
  ),
  titleLarge: GoogleFonts.notoSans(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.onPrimary,
  ),
  titleMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.onPrimary,
  ),
  titleSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: ChanHubDarkColors.onPrimary,
  ),
  bodyLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: ChanHubDarkColors.onSurface,
  ),
  bodyMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: ChanHubDarkColors.onSurface,
  ),
  bodySmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: ChanHubDarkColors.onSurface,
  ),
  labelLarge: GoogleFonts.notoSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: ChanHubDarkColors.onSurface,
  ),
  labelMedium: GoogleFonts.notoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: ChanHubDarkColors.onSurface,
  ),
  labelSmall: GoogleFonts.notoSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: ChanHubDarkColors.onSurface,
  ),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: ChanHubDarkColors.primary,
  onPrimary: ChanHubDarkColors.onPrimary,
  secondary: ChanHubDarkColors.secondary,
  onSecondary: ChanHubDarkColors.onSecondary,
  tertiary: ChanHubDarkColors.tertiary,
  onTertiary: ChanHubDarkColors.onTertiary,
  error: ChanHubDarkColors.error,
  onError: ChanHubDarkColors.onError,
  surface: ChanHubDarkColors.surface,
  onSurface: ChanHubDarkColors.onSurface,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: darkTextTheme,
  primaryTextTheme: darkPrimaryTextTheme,

  // Define the default color of the app.

  // IconThemeData
  iconTheme: const IconThemeData(color: ChanHubDarkColors.primary),
  primaryIconTheme: const IconThemeData(color: ChanHubDarkColors.onPrimary),

  // Splash
  splashColor: ChanHubDarkColors.onSurface.withOpacity(0.1),
  highlightColor: ChanHubDarkColors.primary.withOpacity(0.1),

  // Scaffold
  appBarTheme: const AppBarTheme(
    foregroundColor: ChanHubDarkColors.onPrimary,
    backgroundColor: ChanHubDarkColors.primary,
    centerTitle: false,
    iconTheme: IconThemeData(color: ChanHubDarkColors.onPrimary),
    actionsIconTheme: IconThemeData(color: ChanHubDarkColors.onPrimary),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: ChanHubDarkColors.surface,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: ChanHubDarkColors.onPrimary,
    backgroundColor: ChanHubDarkColors.primary,
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(color: ChanHubDarkColors.primary);
      }
      return const TextStyle(color: ChanHubDarkColors.secondary);
    }),
    iconTheme: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: ChanHubDarkColors.primary);
        }
        return const IconThemeData(color: ChanHubDarkColors.secondary);
      },
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: ChanHubDarkColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: ChanHubDarkColors.surface,
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
            return darkColorScheme.primary.withOpacity(0.4);
          }
          return darkColorScheme.primary;
        },
      ),
      foregroundColor: WidgetStatePropertyAll(darkColorScheme.onPrimary),
      textStyle: WidgetStatePropertyAll(darkTextTheme.titleMedium),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(darkColorScheme.primary),
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(darkTextTheme.titleMedium),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: darkTextTheme.labelMedium,
      floatingLabelStyle: darkTextTheme.titleMedium,
      labelStyle: darkTextTheme.labelMedium,
      prefixIconColor: ChanHubDarkColors.primary,
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      side: WidgetStatePropertyAll(BorderSide.none),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: darkColorScheme.primary.withOpacity(0.1),
    disabledColor: darkColorScheme.primary.withOpacity(0.3),
    selectedColor: darkColorScheme.tertiary,
    secondarySelectedColor: darkColorScheme.tertiary.withOpacity(0.3),
    labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
    padding: const EdgeInsets.all(5.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    side: BorderSide.none,
    labelStyle: darkTextTheme.bodySmall,
    secondaryLabelStyle: darkTextTheme.bodySmall,
    brightness: darkColorScheme.brightness,
    deleteIconColor: darkColorScheme.error,
    deleteIconBoxConstraints:
        const BoxConstraints.expand(width: 20.0, height: 20.0),
  ),

  // InputDecorationTheme
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: darkTextTheme.labelMedium,
    floatingLabelStyle: darkTextTheme.titleMedium,
    labelStyle: darkTextTheme.labelMedium,
    prefixIconColor: ChanHubDarkColors.primary,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ChanHubDarkColors.primary;
        }
        return ChanHubDarkColors.tertiary;
      },
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return ChanHubDarkColors.primary.withOpacity(0.1);
        }
        return ChanHubDarkColors.primary.withOpacity(0.1);
      },
    ),
    trackColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ChanHubDarkColors.primary.withOpacity(0.3);
        }
        return ChanHubDarkColors.tertiary.withOpacity(0.3);
      },
    ),
  ),

  // CardTheme
  cardTheme: CardTheme(
    color: ChanHubDarkColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),

  // Other
  listTileTheme: ListTileThemeData(
    titleTextStyle: darkTextTheme.bodyMedium,
    tileColor: ChanHubDarkColors.surface,
    selectedColor: ChanHubDarkColors.tertiary,
    iconColor: ChanHubDarkColors.primary,
    textColor: ChanHubDarkColors.onSurface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
    dense: true,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    backgroundColor: ChanHubDarkColors.surface,
    iconColor: ChanHubDarkColors.primary,
    collapsedIconColor: ChanHubDarkColors.primary,
    textColor: ChanHubDarkColors.onSurface,
    shape: Border(),
  ),
  dividerTheme: DividerThemeData(
    color: darkColorScheme.primary.withOpacity(0.3),
    thickness: 1.0,
    space: 0.0,
  ),
);
