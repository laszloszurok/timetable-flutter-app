import 'package:flutter/material.dart';
import 'package:timetable_app/utilities/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;

class SettingsProvider extends ChangeNotifier {
  ThemeData _selectedTheme;
  bool _isFullWeek;
  static bool _isDarkTheme;

  SettingsProvider({bool isDarkTheme, bool isFullWeek}) {
    _selectedTheme = isDarkTheme ? ThemeProvider.dark : ThemeProvider.light;
    _isFullWeek = isFullWeek;
    _isDarkTheme = isDarkTheme;
  }

  ThemeData get getSelectedTheme => _selectedTheme;
  bool get isFullWeek => _isFullWeek;
  static bool get isDarkTheme => _isDarkTheme;

  Future<void> toggleFullWeek() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isFullWeek = !_isFullWeek;
    sharedPreferences.setBool(Constants.SHARED_PREFS_FULL_WEEK_KEY, _isFullWeek);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (_selectedTheme == ThemeProvider.dark) {
      _selectedTheme = ThemeProvider.light;
      sharedPreferences.setBool(Constants.SHARED_PREFS_DARK_THEME_KEY, false);
    } else {
      sharedPreferences.setBool(Constants.SHARED_PREFS_DARK_THEME_KEY, true);
      _selectedTheme = ThemeProvider.dark;
    }
    notifyListeners();
  }
}
