import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class LocalizedText {
  LocalizedText(this.locale);

  final Locale locale;

  static LocalizedText of(BuildContext context) {
    return Localizations.of<LocalizedText>(context, LocalizedText);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'main_title': 'Timetable',
      'monday_tab': "Monday",
      'tuesday_tab': "Tuesday",
      'wednesday_tab': "Wednesday",
      'thursday_tab': "Thursday",
      'friday_tab': "Friday",
      'saturday_tab': "Saturday",
      'sunday_tab': "Sunday",
      'settings_label': "Settings",
      'dark_theme_label': "Dark theme: ",
      'full_week_label': "Full week: ",
      'file_operations_label': "Export / Import",
      'export_button_text': "Export timetable",
      'import_button_text': "Import timetable",
      'import_success_title': "Import finished successfully!",
      'export_success_title': "Export finished successfully!!",
      'export_success_content_label': "Exported to:",
      'export_file_name': "timetable.json",
      'app_info_label': "About",
      'app_info_content': "Built with Flutter",
      'new_lesson_monday': "New lesson (Monday)",
      'new_lesson_tuesday': "New lesson (Tuesday)",
      'new_lesson_wednesday': "New lesson (Wednesday)",
      'new_lesson_thursday': "New lesson (Thursday)",
      'new_lesson_friday': "New lesson (Friday)",
      'new_lesson_saturday': "New lesson (Saturday)",
      'new_lesson_sunday': "New lesson (Sunday)",
      'edit_lesson_title': "Edit lesson",
      'require_title_alert_text': "Title field can not be empty!",
      'new_entry_title_hint': "Title",
      'new_entry_location_hint': "Location",
      'new_entry_begins_hint': "Begins at",
      'new_entry_ends_hint': "Ends at",
      'save_button_text': "Save",
      'delete_text': "Delete",
      'delete_alert_title': "Deleting entry",
      'delete_alert_content': "Are you sure?",
      'cancel_text': "Cancel",
      'ok_button_text': "Ok",
    },
    'hu': {
      'main_title': 'Órarend',
      'monday_tab': "Hétfő",
      'tuesday_tab': "Kedd",
      'wednesday_tab': "Szerda",
      'thursday_tab': "Csütörtök",
      'friday_tab': "Péntek",
      'saturday_tab': "Szombat",
      'sunday_tab': "Vasárnap",
      'settings_label': "Beállítások",
      'dark_theme_label': "Sötét téma: ",
      'full_week_label': "Teljes hét: ",
      'file_operations_label': "Exportálás / Importálás",
      'export_button_text': "Órarend exportálása",
      'import_button_text': " Órarend importálása",
      'import_success_title': "Sikeres importálás!",
      'export_success_title': "Sikeres exportálás!",
      'export_success_content': "Exportálva ide:",
      'export_file_name': "orarend.json",
      'app_info_label': "Alkalmazás információk",
      'app_info_content': "Built with Flutter",
      'new_lesson_monday': "Új óra (Hétfő)",
      'new_lesson_tuesday': "Új óra (Kedd)",
      'new_lesson_wednesday': "Új óra (Szerda)",
      'new_lesson_thursday': "Új óra (Csütörtök)",
      'new_lesson_friday': "Új óra (Péntek)",
      'new_lesson_saturday': "Új óra (Szombat)",
      'new_lesson_sunday': "Új óra (Vasárnap)",
      'edit_lesson_title': "Szerkesztés",
      'require_title_alert_text': "Töltsd ki a megnevezés mezőt!",
      'new_entry_title_hint': "Megnevezés",
      'new_entry_location_hint': "Helyszín",
      'new_entry_begins_hint': "Mettől",
      'new_entry_ends_hint': "Meddig",
      'save_button_text': "Mentés",
      'delete_text': "Törlés",
      'delete_alert_title': "Bejegyzés törlése",
      'delete_alert_content': "Biztos vagy benne?",
      'cancel_text': "Mégse",
      'ok_button_text': "Ok",
    },
  };

  String get cancelText => 
      _localizedValues[locale.languageCode]['cancel_text'];

  String get okButtonText =>
      _localizedValues[locale.languageCode]['ok_button_text'];

  String get deleteText => 
      _localizedValues[locale.languageCode]['delete_text'];

  String get delteAlertTitle =>
      _localizedValues[locale.languageCode]['delete_alert_title'];

  String get deleteAlertContent =>
      _localizedValues[locale.languageCode]['delete_alert_content'];

  String get requireTitleAlertText =>
      _localizedValues[locale.languageCode]['require_title_alert_text'];

  String get newEntryTitleHint =>
      _localizedValues[locale.languageCode]['new_entry_title_hint'];

  String get newEntryLocationHint =>
      _localizedValues[locale.languageCode]['new_entry_location_hint'];

  String get newEntryBeginsHint =>
      _localizedValues[locale.languageCode]['new_entry_begins_hint'];

  String get newEntryEndsHint =>
      _localizedValues[locale.languageCode]['new_entry_ends_hint'];

  String get saveButtonText =>
      _localizedValues[locale.languageCode]['save_button_text'];

  String get editLessonTitle =>
      _localizedValues[locale.languageCode]['edit_lesson_title'];

  String get newLessonMonday =>
      _localizedValues[locale.languageCode]['new_lesson_monday'];

  String get newLessonTuesday =>
      _localizedValues[locale.languageCode]['new_lesson_tuesday'];

  String get newLessonWednesday =>
      _localizedValues[locale.languageCode]['new_lesson_wednesday'];

  String get newLessonThursday =>
      _localizedValues[locale.languageCode]['new_lesson_thursday'];

  String get newLessonFriday =>
      _localizedValues[locale.languageCode]['new_lesson_friday'];

  String get newLessonSaturday =>
      _localizedValues[locale.languageCode]['new_lesson_saturday'];

  String get newLessonSunday =>
      _localizedValues[locale.languageCode]['new_lesson_sunday'];

  String get appInfoLabel =>
      _localizedValues[locale.languageCode]['app_info_label'];

  String get appInfoContent =>
      _localizedValues[locale.languageCode]['app_info_content'];

  String get fileOperationsLabel =>
      _localizedValues[locale.languageCode]['file_operations_label'];

  String get exportButtonText =>
      _localizedValues[locale.languageCode]['export_button_text'];

  String get importButtonText =>
      _localizedValues[locale.languageCode]['import_button_text'];

  String get importSuccessTitle =>
      _localizedValues[locale.languageCode]['import_succes_title'];

  String get exportSuccessTitle =>
      _localizedValues[locale.languageCode]['export_success_title'];

  String get exportSuccessContent =>
      _localizedValues[locale.languageCode]['export_success_content'];

  String get exportFileName =>
      _localizedValues[locale.languageCode]['export_file_name'];

  String get mainTitle => 
      _localizedValues[locale.languageCode]['main_title'];

  String get mondayTab => 
      _localizedValues[locale.languageCode]['monday_tab'];

  String get tuesdayTab => 
      _localizedValues[locale.languageCode]['tuesday_tab'];

  String get wednesdayTab =>
      _localizedValues[locale.languageCode]['wednesday_tab'];

  String get thursdayTab =>
      _localizedValues[locale.languageCode]['thursday_tab'];

  String get fridayTab => 
      _localizedValues[locale.languageCode]['friday_tab'];

  String get saturdayTab =>
      _localizedValues[locale.languageCode]['saturday_tab'];

  String get sundayTab => 
      _localizedValues[locale.languageCode]['sunday_tab'];

  String get settingsLabel =>
      _localizedValues[locale.languageCode]['settings_label'];

  String get darkThemeLabel =>
      _localizedValues[locale.languageCode]['dark_theme_label'];

  String get fullWeekLabel =>
      _localizedValues[locale.languageCode]['full_week_label'];
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
