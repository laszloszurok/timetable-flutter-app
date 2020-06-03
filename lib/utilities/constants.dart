library constants;

const String VERSION_NUMBER = "1.0";

const String TIME_FORMAT = "HH:mm";

const String MONDAY_ID = "monday";
const String TUESDAY_ID = "tuesday";
const String WEDNESDAY_ID = "wednesday";
const String THURSDAY_ID = "thursday";
const String FRIDAY_ID = "friday";
const String SATURDAY_ID = "saturday";
const String SUNDAY_ID = "sunday";

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