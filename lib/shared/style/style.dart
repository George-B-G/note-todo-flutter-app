import 'package:flutter/material.dart';
import 'package:note_todo_app/shared/components/constant.dart';

ThemeData buildLightTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: lightBrownColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(color: darkBrownColor),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: darkBrownColor,
        foregroundColor: lightBrownColor,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: lightBrownColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(darkBrownColor),
          iconColor: MaterialStatePropertyAll(lightBrownColor),
          foregroundColor: MaterialStatePropertyAll(lightBrownColor),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkBrownColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: lightBrownColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkBrownColor,
        foregroundColor: lightBrownColor,
      ),
      dividerTheme: DividerThemeData(
        indent: 20,
        endIndent: 20,
        thickness: 3,
        color: darkBrownColor,
      ),
      primaryTextTheme: TextTheme(
        titleMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: darkBrownColor),
      ),
      dialogTheme: DialogTheme(backgroundColor: lightBrownColor),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStatePropertyAll(lightBrownColor),
        checkColor: MaterialStatePropertyAll(darkBrownColor),
      ),
      radioTheme:
          RadioThemeData(fillColor: MaterialStatePropertyAll(darkBrownColor)),
    );

ThemeData buildDarkTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkThemeForegroundColor,
      primaryTextTheme: TextTheme(
        titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkThemeFontColor),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: darkThemeBackgroundColor,
        foregroundColor: darkThemeFontColor,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: darkThemeBackgroundColor,
        surfaceTintColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkThemeBackgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: darkThemeFontColor,
        unselectedItemColor: Colors.grey.shade600,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkThemeBackgroundColor,
        foregroundColor: darkThemeFontColor,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(color: darkThemeFontColor),
        iconColor: darkThemeFontColor,
      ),
      dividerTheme: DividerThemeData(
        indent: 20,
        endIndent: 20,
        thickness: 3,
        color: darkThemeBackgroundColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(darkThemeFontColor),
          iconColor: MaterialStatePropertyAll(darkThemeBackgroundColor),
          foregroundColor: MaterialStatePropertyAll(darkThemeBackgroundColor),
        ),
      ),
      dialogTheme: DialogTheme(backgroundColor: darkThemeBackgroundColor),
      radioTheme: RadioThemeData(
          fillColor: MaterialStatePropertyAll(darkThemeFontColor)),
    );
