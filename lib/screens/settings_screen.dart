import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/utilities/localization.dart';
import 'package:timetable_app/utilities/settings_change_notifier.dart';
import 'package:timetable_app/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedText.of(context).settingsLabel),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Card(
              child: Consumer<SettingsProvider>(
                builder: (context, SettingsProvider settingsProvider, child) =>
                    SwitchListTile(
                  contentPadding: EdgeInsets.all(15),
                  title: Text(
                    LocalizedText.of(context).darkThemeLabel,
                    style: TextStyle(
                      color: ThemeProvider.listTileTitleColor,
                    ),
                  ),
                  value: SettingsProvider.isDarkTheme,
                  onChanged: (value) {
                    settingsProvider.toggleTheme();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Consumer<SettingsProvider>(
                builder: (context, SettingsProvider settingsProvider, child) =>
                    SwitchListTile(
                  contentPadding: EdgeInsets.all(15),
                  title: Text(
                    LocalizedText.of(context).fullWeekLabel,
                    style: TextStyle(
                      color: ThemeProvider.listTileTitleColor,
                    ),
                  ),
                  value: settingsProvider.isFullWeek,
                  onChanged: (value) {
                    settingsProvider.toggleFullWeek();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
