library constants;

const String MAIN_TITLE = "Órarend";
const String VERSION_NUMBER = "1.0";

const String TIME_FORMAT = "HH:mm";

const String MONDAY_ID = "monday";
const String TUESDAY_ID = "tuesday";
const String WEDNESDAY_ID = "wednesday";
const String THURSDAY_ID = "thursday";
const String FRIDAY_ID = "friday";
const String SATURDAY_ID = "saturday";
const String SUNDAY_ID = "sunday";

const String MONDAY_TAB = "Hétfő";
const String TUESDAY_TAB = "Kedd";
const String WEDNESDAY_TAB = "Szerda";
const String THURSDAY_TAB = "Csütörtök";
const String FRIDAY_TAB = "Péntek";
const String SATURDAY_TAB = "Szombat"; 
const String SUNDAY_TAB = "Vasárnap";

const String SETTINGS_LABEL = "Beállítások";
const String SETTINGS_TITLE = "Beállítások";
const String DARK_THEME_LABEL = "Sötét téma: ";
const String FULL_WEEK_LABEL = "Teljes hét: ";

const String APP_INFO_LABEL = "Alkalmazás információk";
const String APP_INFO_CONTENT = "Built with Flutter";

const String NEW_LESSON_MONDAY = "Új óra (Hétfő)";
const String NEW_LESSON_TUESDAY = "Új óra (Kedd)";
const String NEW_LESSON_WEDNESDAY = "Új óra (Szerda)";
const String NEW_LESSON_THURSDAY = "Új óra (Csütörtök)";
const String NEW_LESSON_FRIDAY = "Új óra (Péntek)";
const String NEW_LESSON_SATURDAY = "Új óra (Szombat)";
const String NEW_LESSON_SUNDAY = "Új óra (Vasárnap)";

const String EDIT_LESSON_TITLE = "Szerkesztés";

const String REQUIRE_TITLE_ALERT_TEXT = "Töltsd ki a megnevezés mezőt!";
const String NEW_ENTRY_TITLE_HINT = "Megnevezés";
const String NEW_ENTRY_LOCATION_HINT = "Helyszín";
const String NEW_ENTRY_BEGINS_HINT = "Mettől";
const String NEW_ENTRY_ENDS_HINT = "Meddig";
const String SAVE_BUTTON_TEXT = "Mentés";

const String DELETE_TEXT = "Törlés";
const String DELETE_ALERT_TITLE = "Bejegyzés törlése";
const String DELETE_ALERT_CONTENT = "Biztos vagy benne?";

const String CANCEL_TEXT = "Mégse";
const String OK_BUTTON_TEXT = "Ok";

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

const String SHARED_PREFS_DARK_THEME_KEY = "isDarkTheme";
const String SHARED_PREFS_FULL_WEEK_KEY = "isFullWeek";

const int NUM_OF_TABS_FIVE_DAY_WEEK = 5;
const int NUM_OF_TABS_FULL_WEEK = 7;