import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/utilities/settings_change_notifier.dart';
import 'package:timetable_app/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.SETTINGS_TITLE),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Card(
              child: Consumer<SettingsChangeNotifier>(
                builder: (context, settingsChangeNotifier, child) =>
                    SwitchListTile(
                  contentPadding: EdgeInsets.all(15),
                  title: Text(
                    Constants.DARK_THEME_LABEL,
                    style: TextStyle(
                      color: ActiveTheme.listTileTitleColor,
                    ),
                  ),
                  value: SettingsChangeNotifier.darkTheme,
                  onChanged: (value) {
                    settingsChangeNotifier.toggleTheme();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Consumer<SettingsChangeNotifier>(
                builder: (context, settingsChangeNotifier, child) =>
                    SwitchListTile(
                  contentPadding: EdgeInsets.all(15),
                  title: Text(
                    Constants.FULL_WEEK_LABEL,
                    style: TextStyle(
                      color: ActiveTheme.listTileTitleColor,
                    ),
                  ),
                  value: SettingsChangeNotifier.fullWeek,
                  onChanged: (value) {
                    settingsChangeNotifier.toggleFullWeek();
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
