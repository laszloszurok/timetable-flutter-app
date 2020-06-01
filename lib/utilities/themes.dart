import 'package:flutter/material.dart';
import 'package:timetable_app/utilities/settings_change_notifier.dart';

class ThemeProvider {
  /* Colors used in dark theme */
  static final Color _mainBackgroundColorDark = Color(0xFF1e2227);
  static final Color _secondaryBackgroundColorDark = Color(0xFF282c34);
  static final Color _mainForeGroundColorDark = Color(0xff9fb2bf);
  static final Color _cardSubtitleColorDark = Colors.white30;
  static final Color _floatingActionButtonBackgroundColorDark = Colors.deepPurpleAccent;
  static final Color _floatingActionButtonForegroundColorDark = Colors.white;
  static final Color _accentColorDark = Colors.deepPurpleAccent;
  static final Color _toggleButtonActiveColorDark = Colors.deepPurpleAccent;
  static final Color _activeTabIndicatorColorDark = Colors.deepPurpleAccent;
  static final Color _buttonColorDark = Colors.deepPurpleAccent;

  /* Colors used in light theme */
  static final Color _mainBackgroundColorLight = Colors.white;
  static final Color _secondaryBackgroundColorLight = Colors.blue;
  static final Color _mainForegroundColorLight = Colors.black;
  static final Color _secondaryForegroundColorLight = Colors.white;
  static final Color _buttonColorLight = Colors.blue;

  /* I could not change the color of some elements through ThemeData,
   * so I'm setting them with the help of static getters and a static
   * boolean variable in SettingsProvider to determine if dark or
   * light theme is active and set the colors accordingly. */
  static Color _listTileTitleColor;
  static Color _drawerHeaderDecorationColor;
  static Color _drawerTitleColor;

  static Color get listTileTitleColor {
    _listTileTitleColor = SettingsProvider.isDarkTheme
        ? _mainForeGroundColorDark
        : _mainForegroundColorLight;
    return _listTileTitleColor;
  }

  static Color get drawerHeaderDecorationColor {
    _drawerHeaderDecorationColor = SettingsProvider.isDarkTheme
        ? _secondaryBackgroundColorDark
        : _secondaryBackgroundColorLight;
    return _drawerHeaderDecorationColor;
  }

  static Color get drawerTitleColor {
    _drawerTitleColor = SettingsProvider.isDarkTheme
        ? _mainForeGroundColorDark
        : _secondaryForegroundColorLight;
    return _drawerTitleColor;
  }

  static ThemeData light = ThemeData.light().copyWith(
    textTheme: ThemeData.light().copyWith().textTheme,
    scaffoldBackgroundColor: _mainBackgroundColorLight,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _buttonColorLight,
    ),
  );

  static ThemeData dark = ThemeData.dark().copyWith(
    textTheme: TextTheme(
      caption: TextStyle(
        color: _cardSubtitleColorDark,
      ),
      bodyText1: TextStyle(
        color: _mainForeGroundColorDark,
      ),
    ),
    canvasColor: _mainBackgroundColorDark, // background of the drawer
    scaffoldBackgroundColor: _mainBackgroundColorDark,
    appBarTheme: AppBarTheme(
      color: _secondaryBackgroundColorDark,
      iconTheme: IconThemeData(
        color: _mainForeGroundColorDark,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: _mainForeGroundColorDark,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: _mainForeGroundColorDark,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _floatingActionButtonBackgroundColorDark,
      foregroundColor: _floatingActionButtonForegroundColorDark,
    ),
    accentColor: _accentColorDark,
    toggleableActiveColor: _toggleButtonActiveColorDark,
    indicatorColor: _activeTabIndicatorColorDark,
    buttonTheme: ButtonThemeData(
      buttonColor: _buttonColorDark,
    ),
    cardTheme: CardTheme(
      color: _secondaryBackgroundColorDark,
    ),
    iconTheme: IconThemeData(
      color: _mainForeGroundColorDark,
    ),
  );
}
