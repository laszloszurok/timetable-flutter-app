import 'package:flutter/material.dart';
import 'package:timetable_app/utilities/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;

/* lightTheme() and darkTheme() functions are defined in /utilities/theme.dart 
 * The objects defined below are used in main.dart to set the corret theme. */
ThemeData light = ActiveTheme.lightTheme();
ThemeData dark = ActiveTheme.darkTheme();

class SettingsChangeNotifier extends ChangeNotifier {
  SharedPreferences _prefs;

  static bool _darkTheme;
  static bool _fullWeek;

  SettingsChangeNotifier() {
    _darkTheme = true;
    _fullWeek = true;
    _loadThemeFromPrefs();
  }

  static bool get darkTheme => _darkTheme;
  static bool get fullWeek => _fullWeek;

  toggleTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
    _saveThemeToPrefs();
  }

  toggleFullWeek() {
    _fullWeek = !_fullWeek;
    notifyListeners();
    _saveThemeToPrefs();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadThemeFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(Constants.SHARED_PREFS_DARK_THEME_KEY) ?? true;
    _fullWeek = _prefs.getBool(Constants.SHARED_PREFS_FULL_WEEK_KEY) ?? true;
    notifyListeners();
  }

  _saveThemeToPrefs() async {
    await _initPrefs();
    _prefs.setBool(Constants.SHARED_PREFS_DARK_THEME_KEY, _darkTheme);
    _prefs.setBool(Constants.SHARED_PREFS_FULL_WEEK_KEY, _fullWeek);
  }
}
