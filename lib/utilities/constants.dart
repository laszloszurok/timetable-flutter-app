library constants;

const String VERSION_NUMBER = "1.0";

const String TIME_FORMAT = "HH:mm";

/* to identify tabs and lists */
const String MONDAY_ID = "monday";
const String TUESDAY_ID = "tuesday";
const String WEDNESDAY_ID = "wednesday";
const String THURSDAY_ID = "thursday";
const String FRIDAY_ID = "friday";
const String SATURDAY_ID = "saturday";
const String SUNDAY_ID = "sunday";

/* database */
const String TABLE_NAME = "lesson";
const String ID_COL = "id";
const String TITLE_COL = "title";
const String LOCATION_COL = "location";
const String BEGINS_COL = "begins_at";
const String ENDS_COL = "ends_at";
const String DAY_COL = "day";
const String CREATE_TABLE = "CREATE TABLE $TABLE_NAME ("
    "$ID_COL INTEGER PRIMARY KEY AUTOINCREMENT, "
    "$TITLE_COL TEXT, "
    "$LOCATION_COL TEXT, "
    "$BEGINS_COL TEXT, "
    "$ENDS_COL TEXT, "
    "$DAY_COL TEXT "
    ");";
const String DATABASE_PATH = "$TABLE_NAME.db";

/* keys used for getting translated text */
const String MAIN_TITLE = "main_title";
const String MONDAY_TAB = 'monday_tab';
const String TUESDAY_TAB = 'tuesday_tab';
const String WEDNESDAY_TAB = 'wednesday_tab';
const String THURSDAY_TAB = 'thursday_tab';
const String FRIDAY_TAB = 'friday_tab';
const String SATURDAY_TAB = 'saturday_tab';
const String SUNDAY_TAB = 'sunday_tab';
const String SETTINGS_LABEL = 'settings_label';
const String DARK_THEME_LABEL = 'dark_theme_label';
const String FULL_WEEK_LABEL = 'full_week_label';
const String FILE_OPERATIONS_LABEL = 'file_operations_label';
const String EXPORT_BUTTON_TEXT = 'export_button_text';
const String IMPORT_BUTTON_TEXT = 'import_button_text';
const String IMPORT_SUCCESS_TITLE = 'import_success_title';
const String EXPORT_SUCCESS_TITLE = 'export_success_title';
const String EXPORT_SUCCESS_CONTENT = 'export_success_content';
const String EXPORT_FILE_NAME = 'export_file_name';
const String APP_INFO_LABEL = 'app_info_label';
const String APP_INFO_CONTENT = 'app_info_content';
const String NEW_LESSON_MONDAY = 'new_lesson_monday';
const String NEW_LESSON_TUESDAY = 'new_lesson_tuesday';
const String NEW_LESSON_WEDNESDAY = 'new_lesson_wednesday';
const String NEW_LESSON_THURSDAY = 'new_lesson_thursday';
const String NEW_LESSON_FRIDAY = 'new_lesson_friday';
const String NEW_LESSON_SATURDAY = 'new_lesson_saturday';
const String NEW_LESSON_SUNDAY = 'new_lesson_sunday';
const String EDIT_LESSON_TITLE = 'edit_lesson_title';
const String REQUIRE_TITLE_ALERT_TEXT = 'require_title_alert_text';
const String NEW_ENTRY_TITLE_HINT = 'new_entry_title_hint';
const String NEW_ENTRY_LOCATION_HINT = 'new_entry_location_hint';
const String NEW_ENTRY_BEGINS_HINT = 'new_entry_begins_hint';
const String NEW_ENTRY_ENDS_HINT = 'new_entry_ends_hint';
const String SAVE_BUTTON_TEXT = 'save_button_text';
const String DELETE_TEXT = 'delete_text';
const String DELETE_ALERT_TITLE = 'delete_alert_title';
const String DELETE_ALERT_CONTENT = 'delete_alert_content';
const String CANCEL_TEXT = 'cancel_text';
const String OK_BUTTON_TEXT = 'ok_button_text';

/* keys used for storing settings in shared prefs */
const String SHARED_PREFS_DARK_THEME_KEY = "isDarkTheme";
const String SHARED_PREFS_FULL_WEEK_KEY = "isFullWeek";

/* num of tabs to show based on settings */
const int NUM_OF_TABS_FIVE_DAY_WEEK = 5;
const int NUM_OF_TABS_FULL_WEEK = 7;
