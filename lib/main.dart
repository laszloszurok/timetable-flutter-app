import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable_app/utilities/localization.dart';
import 'package:timetable_app/utilities/settings_change_notifier.dart';
import 'package:provider/provider.dart';
import 'screens/lesson_list_screen.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => SettingsProvider(
            isDarkTheme: sharedPreferences
                    .getBool(Constants.SHARED_PREFS_DARK_THEME_KEY) ??
                false,
            isFullWeek: sharedPreferences
                    .getBool(Constants.SHARED_PREFS_FULL_WEEK_KEY) ??
                true,
          ),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, SettingsProvider settingsProvider, child) {
        return MaterialApp(
          onGenerateTitle: (BuildContext context) =>
              LocalizedText.of(context).mainTitle,
          localizationsDelegates: [
            const TextLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('hu', ''),
          ],
          theme: settingsProvider.getSelectedTheme,
          home: LessonListScreen(),
        );
      },
    );
  }
}
