import 'package:flutter/material.dart';
import 'package:timetable_app/utilities/settings_change_notifier.dart';
import 'package:provider/provider.dart';

import 'screens/lesson_list_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsChangeNotifier(),
      child: Consumer<SettingsChangeNotifier>(
        builder: (context, SettingsChangeNotifier settingsChangeNotifier, child){
          return MaterialApp(
            theme: SettingsChangeNotifier.darkTheme ? dark : light,
            home: LessonListScreen(),
          );
        },
      ),
    );
  }
}