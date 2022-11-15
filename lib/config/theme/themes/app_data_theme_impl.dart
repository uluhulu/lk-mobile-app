import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../elements/app_colors.dart';
import '../elements/app_data_theme.dart';

///
class AppDataThemeImpl implements AppDataTheme {
  AppDataThemeImpl(this.appColors) {
    cardTheme = CardTheme(
      color: appColors.cardColor,
      elevation: 0.0,
      margin: EdgeInsets.zero,
    );

    tabBarTheme = TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appColors.primaryColor,
          ),
        ),
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelColor: appColors.primaryColor,
      unselectedLabelColor: Colors.black26,
    );

    bottomNavigationBarTheme = BottomNavigationBarThemeData(
      backgroundColor: appColors.cardColor,
      selectedIconTheme: IconThemeData(
        color: appColors.primaryColor,
        size: 24,
      ),
      unselectedIconTheme: IconThemeData(
        color: appColors.accentColor,
        size: 24,
      ),
      selectedItemColor: appColors.primaryColor,
      selectedLabelStyle: TextStyle(
        color: appColors.primaryColor,
        fontSize: 12,
      ),
      unselectedItemColor: appColors.accentColor,
      unselectedLabelStyle: TextStyle(
        color: appColors.accentColor,
        fontSize: 12,
      ),
      showUnselectedLabels: true,
    );

    elevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.black12;
            }

            return appColors.primaryButtonColor;
          },
        ),
        // padding: MaterialStateProperty.all(
        //   const EdgeInsets.symmetric(
        //     vertical: 30,
        //   ),
        // ),
        // shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
        // textStyle: MaterialStateProperty.all(
        //   const TextStyle(
        //     fontSize: 20,
        //   ),
        // ),
      ),
    );
  }

  final AppColors appColors;

  @override
  InputDecorationTheme? inputDecorationTheme = const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Color.fromARGB(255, 175, 175, 175),
    ),
    labelStyle: TextStyle(
      fontSize: 18,
      height: 0,
    ),
  );

  @override
  VisualDensity? visualDensity = const VisualDensity(
    horizontal: VisualDensity.minimumDensity,
    vertical: VisualDensity.minimumDensity,
  );

  @override
  late CardTheme? cardTheme;

  @override
  DataTableThemeData? dataTableTheme = const DataTableThemeData(
    columnSpacing: 20,
    horizontalMargin: 20,
  );

  @override
  TabBarTheme? tabBarTheme;

  @override
  late BottomNavigationBarThemeData? bottomNavigationBarTheme;

  @override
  late ElevatedButtonThemeData? elevatedButtonTheme;

  @override
  AppBarTheme? appBarTheme = const AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 39, 52, 148),
      systemNavigationBarColor: Color.fromARGB(255, 255, 255, 255),
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: true,
      systemStatusBarContrastEnforced: true,
    ),
    backgroundColor: Color.fromARGB(255, 39, 52, 148),
    iconTheme: IconThemeData(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    titleTextStyle: TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 14,
    ),
    textTheme: TextTheme(
      headline3: TextStyle(
        color: Color.fromARGB(255, 46, 46, 46),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline4: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      headline5: TextStyle(
        fontSize: 12,
        color: Colors.white70,
      ),
    ),
  );

  @override
  IconThemeData? iconTheme = const IconThemeData(color: Colors.black);
}
