import 'package:flutter/material.dart';
import 'package:timetable_app/utilities/settings_change_notifier.dart';

class ActiveTheme {
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
  static final Color _cardSubtitleColorLight = Colors.grey;
  static final Color _buttonColorLight = Colors.blue;

  static Color _listTileTitleColor;
  static Color _drawerHeaderDecorationColor;
  static Color _drawerTitleColor;

  static Color get listTileTitleColor {
    _listTileTitleColor = SettingsChangeNotifier.darkTheme
        ? _mainForeGroundColorDark
        : _mainForegroundColorLight;
    return _listTileTitleColor;
  }

  static Color get drawerHeaderDecorationColor {
    _drawerHeaderDecorationColor = SettingsChangeNotifier.darkTheme
        ? _secondaryBackgroundColorDark
        : _secondaryBackgroundColorLight;
    return _drawerHeaderDecorationColor;
  }

  static Color get drawerTitleColor {
    _drawerTitleColor = SettingsChangeNotifier.darkTheme
        ? _mainForeGroundColorDark
        : _secondaryForegroundColorLight;
    return _drawerTitleColor;
  }

  static ThemeData darkTheme() {
    TextTheme _textThemeDark(TextTheme base) {
      return base.copyWith(
        caption: base.caption.copyWith(
          color: _cardSubtitleColorDark,
        ),
        bodyText1: TextStyle(
          color: _mainForeGroundColorDark,
        ),
      );
    }

    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      canvasColor: _mainBackgroundColorDark, // background of the drawer
      scaffoldBackgroundColor: _mainBackgroundColorDark,
      textTheme: _textThemeDark(base.textTheme),
      appBarTheme: AppBarTheme(
        color: _secondaryBackgroundColorDark,
        iconTheme: IconThemeData(
          color: _mainForeGroundColorDark,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: _mainForeGroundColorDark,
            fontSize: 24,
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

  static ThemeData lightTheme() {
    TextTheme _textThemeLight(TextTheme base) {
      return base.copyWith(
        caption: base.caption.copyWith(
          color: _cardSubtitleColorLight,
        ),
      );
    }

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      textTheme: _textThemeLight(base.textTheme),
      scaffoldBackgroundColor: _mainBackgroundColorLight,
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 24),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _buttonColorLight,
      ),
    );
  }
}
