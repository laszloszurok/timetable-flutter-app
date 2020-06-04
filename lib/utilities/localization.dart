import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:timetable_app/utilities/constants.dart' as Constants;

class LocalizedText {
  final Locale locale;
  LocalizedText(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      Constants.MAIN_TITLE: 'Timetable',
      Constants.MONDAY_TAB: "Monday",
      Constants.TUESDAY_TAB: "Tuesday",
      Constants.WEDNESDAY_TAB: "Wednesday",
      Constants.THURSDAY_TAB: "Thursday",
      Constants.FRIDAY_TAB: "Friday",
      Constants.SATURDAY_TAB: "Saturday",
      Constants.SUNDAY_TAB: "Sunday",
      Constants.SETTINGS_LABEL: "Settings",
      Constants.DARK_THEME_LABEL: "Dark theme: ",
      Constants.FULL_WEEK_LABEL: "Full week: ",
      Constants.FILE_OPERATIONS_LABEL: "Export / Import",
      Constants.EXPORT_BUTTON_TEXT: "Export timetable",
      Constants.IMPORT_BUTTON_TEXT: "Import timetable",
      Constants.IMPORT_SUCCESS_TITLE: "Import finished successfully!",
      Constants.EXPORT_SUCCESS_TITLE: "Export finished successfully!!",
      Constants.EXPORT_SUCCESS_CONTENT: "Exported to:",
      Constants.EXPORT_FILE_NAME: "timetable.json",
      Constants.APP_INFO_LABEL: "About",
      Constants.APP_INFO_CONTENT: "Simple timetable application for managing your lessons and tasks",
      Constants.NEW_LESSON_MONDAY: "New lesson (Monday)",
      Constants.NEW_LESSON_TUESDAY: "New lesson (Tuesday)",
      Constants.NEW_LESSON_WEDNESDAY: "New lesson (Wednesday)",
      Constants.NEW_LESSON_THURSDAY: "New lesson (Thursday)",
      Constants.NEW_LESSON_FRIDAY: "New lesson (Friday)",
      Constants.NEW_LESSON_SATURDAY: "New lesson (Saturday)",
      Constants.NEW_LESSON_SUNDAY: "New lesson (Sunday)",
      Constants.EDIT_LESSON_TITLE: "Edit lesson",
      Constants.REQUIRE_TITLE_ALERT_TEXT: "Title field can not be empty!",
      Constants.NEW_ENTRY_TITLE_HINT: "Title",
      Constants.NEW_ENTRY_LOCATION_HINT: "Location",
      Constants.NEW_ENTRY_BEGINS_HINT: "Begins at",
      Constants.NEW_ENTRY_ENDS_HINT: "Ends at",
      Constants.SAVE_BUTTON_TEXT: "Save",
      Constants.DELETE_TEXT: "Delete",
      Constants.DELETE_ALERT_TITLE: "Deleting entry",
      Constants.DELETE_ALERT_CONTENT: "Are you sure?",
      Constants.CANCEL_TEXT: "Cancel",
      Constants.OK_BUTTON_TEXT: "Ok",
    },
    'hu': {
       Constants.MAIN_TITLE:'Órarend',
       Constants.MONDAY_TAB: "Hétfő",
       Constants.TUESDAY_TAB: "Kedd",
       Constants.WEDNESDAY_TAB: "Szerda",
       Constants.THURSDAY_TAB: "Csütörtök",
       Constants.FRIDAY_TAB: "Péntek",
       Constants.SATURDAY_TAB: "Szombat",
       Constants.SUNDAY_TAB: "Vasárnap",
       Constants.SETTINGS_LABEL: "Beállítások",
       Constants.DARK_THEME_LABEL: "Sötét téma: ",
       Constants.FULL_WEEK_LABEL: "Teljes hét: ",
       Constants.FILE_OPERATIONS_LABEL: "Exportálás / Importálás",
       Constants.EXPORT_BUTTON_TEXT: "Órarend exportálása",
       Constants.IMPORT_BUTTON_TEXT: " Órarend importálása",
       Constants.IMPORT_SUCCESS_TITLE: "Sikeres importálás!",
       Constants.EXPORT_SUCCESS_TITLE: "Sikeres exportálás!",
       Constants.EXPORT_SUCCESS_CONTENT: "Exportálva ide:",
       Constants.EXPORT_FILE_NAME: "orarend.json",
       Constants.APP_INFO_LABEL: "Alkalmazás információk",
       Constants.APP_INFO_CONTENT: "Simple timetable application for managing your lessons and tasks",
       Constants.NEW_LESSON_MONDAY: "Új óra (Hétfő)",
       Constants.NEW_LESSON_TUESDAY: "Új óra (Kedd)",
       Constants.NEW_LESSON_WEDNESDAY: "Új óra (Szerda)",
       Constants.NEW_LESSON_THURSDAY: "Új óra (Csütörtök)",
       Constants.NEW_LESSON_FRIDAY: "Új óra (Péntek)",
       Constants.NEW_LESSON_SATURDAY: "Új óra (Szombat)",
       Constants.NEW_LESSON_SUNDAY: "Új óra (Vasárnap)",
       Constants.EDIT_LESSON_TITLE: "Szerkesztés",
       Constants.REQUIRE_TITLE_ALERT_TEXT: "Töltsd ki a megnevezés mezőt!",
       Constants.NEW_ENTRY_TITLE_HINT: "Megnevezés",
       Constants.NEW_ENTRY_LOCATION_HINT: "Helyszín",
       Constants.NEW_ENTRY_BEGINS_HINT: "Mettől",
       Constants.NEW_ENTRY_ENDS_HINT: "Meddig",
       Constants.SAVE_BUTTON_TEXT: "Mentés",
       Constants.DELETE_TEXT: "Törlés",
       Constants.DELETE_ALERT_TITLE: "Bejegyzés törlése",
       Constants.DELETE_ALERT_CONTENT: "Biztos vagy benne?",
       Constants.CANCEL_TEXT: "Mégse",
       Constants.OK_BUTTON_TEXT: "Ok",
    },
  };

  String translate(key) {
    return _localizedValues[locale.languageCode][key];
  }

  static String of(BuildContext context, String key) {
    return Localizations.of<LocalizedText>(context, LocalizedText)
        .translate(key);
  }

}

class TextLocalizationsDelegate extends LocalizationsDelegate<LocalizedText> {
  const TextLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hu'].contains(locale.languageCode);

  @override
  Future<LocalizedText> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<LocalizedText>(LocalizedText(locale));
  }

  @override
  bool shouldReload(TextLocalizationsDelegate old) => false;
}
