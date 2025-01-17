import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:timetable_app/models/lesson.dart';
import 'package:timetable_app/screens/settings_screen.dart';
import 'package:timetable_app/utilities/db_helper.dart';
import 'package:timetable_app/utilities/localization.dart';
import 'package:timetable_app/utilities/settings_change_notifier.dart';
import 'package:timetable_app/utilities/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson.dart';
import 'file_operation_screen.dart';
import 'lesson_manager_screen.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;

class LessonListScreen extends StatefulWidget {
  LessonListScreen();
  @override
  _LessonListScreenState createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  DataBaseHelper dataBaseHelper = DataBaseHelper();

  /* if we add a new entry, the title textfield will be focused automatically,
   * if we open an existing one, autofocus will be disabled */
  bool isNewEntry;

  // These lists will contain the lessons for each day separately
  List<Lesson> _mondayList,
      _tuesdayList,
      _wednesdayList,
      _thursdayList,
      _fridayList,
      _saturdayList,
      _sundayList;

  int mondayListLength = 0;
  int tuesdayListLength = 0;
  int wednesdayListLength = 0;
  int thursdayListLength = 0;
  int fridayListLength = 0;
  int saturdayListLength = 0;
  int sundayListLength = 0;

  // custom tab controller, needed for getting the index of the active tab
  TabController _tabController;

  /* ScrollController and _fabIsVisible, are used for hiding the
   * floating action button when the user scrolls one of the listviews.
   * The FAB can cover the delete button of an item. While the FAB is
   * hidden the user can reach the delete button. Then it will be
   * visible again after a delay. */
  ScrollController _hideButtonController;
  bool _fabIsVisible;

  @override
  void initState() {
    super.initState();

    /* Hide add button while scrolling a list */
    _fabIsVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(_hideButtonWhileScrolling);

    /* _tabController will be overwritten in openDay(), but have to be initalized 
     * here, becouse we retrive the number of tabs to show in an async function,
     * so we have to make sure _tabController is not null. */
    _tabController =
        TabController(length: Constants.NUM_OF_TABS_FIVE_DAY_WEEK, vsync: this);

    /* Getting the number of tabs to show, initalizing _tabController
     * and animating to the rigth tab. */
    getNumOfTabs().then((numOfTabs) {
      openDay(numOfTabs);
    });

    _tabController.addListener(_handleTabIndex);
  }

  void _handleTabIndex() {
    //setState(() {});
  }

  void _hideButtonWhileScrolling() {
    if (_hideButtonController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_fabIsVisible) {
        /* only set when the previous state is false
           * Less widget rebuilds */
        setState(() {
          _fabIsVisible = false;
        });
      }
    } else {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_fabIsVisible) {
          /* only set when the previous state is false
             * Less widget rebuilds */
          setState(() {
            _fabIsVisible = false;
          });
        }
      }
    }
  }

  /* We have to determine if we have to show 5 or 7 tabs 
   * (based on what the user has set) and initalize the 
   * _tabController with the right value. */
  Future<int> getNumOfTabs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _fullWeek =
        prefs.getBool(Constants.SHARED_PREFS_FULL_WEEK_KEY) ?? false;
    return _fullWeek
        ? Constants.NUM_OF_TABS_FULL_WEEK
        : Constants.NUM_OF_TABS_FIVE_DAY_WEEK;
  }

  /* Function to determine which day of the week it is, then animate to the
   * right tab accordingly.  */
  void openDay(int numOfTabs) {
    _tabController = TabController(length: numOfTabs, vsync: this);
    _tabController.addListener(_handleTabIndex);

    DateTime now = DateTime.now();
    int tabIndex = now.weekday - 1;

    if (numOfTabs == Constants.NUM_OF_TABS_FULL_WEEK) {
      switch (tabIndex) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
          _tabController.animateTo(tabIndex);
          break;
        default:
          debugPrint("Unknown weekday");
      }
    } else {
      switch (tabIndex) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
          _tabController.animateTo(tabIndex);
          break;
        case 5:
        case 6:
          _tabController.animateTo(4); // the last tab
          break;
        default:
          debugPrint("Unknown weekday");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    // if the lists are empty we fetch lessons from the db
    if (_mondayList == null) {
      _mondayList = List();
      updateListView(Constants.MONDAY_ID);
    }
    if (_tuesdayList == null) {
      _tuesdayList = List();
      updateListView(Constants.TUESDAY_ID);
    }
    if (_wednesdayList == null) {
      _wednesdayList = List();
      updateListView(Constants.WEDNESDAY_ID);
    }
    if (_thursdayList == null) {
      _thursdayList = List();
      updateListView(Constants.THURSDAY_ID);
    }
    if (_fridayList == null) {
      _fridayList = List();
      updateListView(Constants.FRIDAY_ID);
    }
    if (settingsProvider.isFullWeek) {
      if (_saturdayList == null) {
        _saturdayList = List();
        updateListView(Constants.SATURDAY_ID);
      }
      if (_sundayList == null) {
        _sundayList = List();
        updateListView(Constants.SUNDAY_ID);
      }
    }
    if (settingsProvider.isFullWeek &&
        _tabController.length == Constants.NUM_OF_TABS_FIVE_DAY_WEEK) {
      _tabController.dispose();
      openDay(Constants.NUM_OF_TABS_FULL_WEEK);
    } else if (!settingsProvider.isFullWeek &&
        _tabController.length == Constants.NUM_OF_TABS_FULL_WEEK) {
      _tabController.dispose();
      openDay(Constants.NUM_OF_TABS_FIVE_DAY_WEEK);
    }
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(LocalizedText.of(context, Constants.MAIN_TITLE)),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: settingsProvider.isFullWeek
              ? <Widget>[
                  Tab(text: LocalizedText.of(context, Constants.MONDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.TUESDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.WEDNESDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.THURSDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.FRIDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.SATURDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.SUNDAY_TAB)),
                ]
              : <Widget>[
                  Tab(text: LocalizedText.of(context, Constants.MONDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.TUESDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.WEDNESDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.THURSDAY_TAB)),
                  Tab(text: LocalizedText.of(context, Constants.FRIDAY_TAB)),
                ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: settingsProvider.isFullWeek
            ? [
                populateListView(_mondayList, mondayListLength),
                populateListView(_tuesdayList, tuesdayListLength),
                populateListView(_wednesdayList, wednesdayListLength),
                populateListView(_thursdayList, thursdayListLength),
                populateListView(_fridayList, fridayListLength),
                populateListView(_saturdayList, saturdayListLength),
                populateListView(_sundayList, sundayListLength),
              ]
            : [
                populateListView(_mondayList, mondayListLength),
                populateListView(_tuesdayList, tuesdayListLength),
                populateListView(_wednesdayList, wednesdayListLength),
                populateListView(_thursdayList, thursdayListLength),
                populateListView(_fridayList, fridayListLength),
              ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                LocalizedText.of(context, Constants.MAIN_TITLE),
                style: TextStyle(
                  fontSize: 24,
                  color: ThemeProvider.drawerTitleColor,
                ),
              ),
              decoration: BoxDecoration(
                color: ThemeProvider.drawerHeaderDecorationColor,
              ),
            ),
            ListTile(
              title: Text(LocalizedText.of(context, Constants.SETTINGS_LABEL)),
              onTap: () {
                // Navigating to the settings screen
                // Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                  LocalizedText.of(context, Constants.FILE_OPERATIONS_LABEL)),
              onTap: () async {
                // Navigating to the settings screen
                // Navigator.pop(context); // close the drawer
                bool didImport = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FileOperationScreen(),
                      ),
                    ) ??
                    true;
                if (didImport) {
                  updateListView("all");
                }
              },
            ),
            ListTile(
              title: Text(LocalizedText.of(context, Constants.APP_INFO_LABEL)),
              onTap: () {
                // Show app infos
                showAboutDialog(
                  context: context,
                  applicationName:
                      LocalizedText.of(context, Constants.MAIN_TITLE),
                  applicationVersion: Constants.VERSION_NUMBER,
                  applicationLegalese:
                      LocalizedText.of(context, Constants.APP_INFO_CONTENT),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _fabIsVisible,
        child: FloatingActionButton(
          onPressed: () async {
            isNewEntry = true;
            /* Need a delay here, becouse if the user swipes to change tab and then immediately
             * taps the floating action button, the new entry will be added to the perviously 
             * active tab (becouse the animation of the tabcontroller is not over yet) 
             * TODO: hide the FAB while switching tabs maybe? */
            await Future.delayed(const Duration(milliseconds: 500));
            if (settingsProvider.isFullWeek) {
              switch (_tabController.index) {
                case 0:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.MONDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_MONDAY),
                      isNewEntry);
                  break;
                case 1:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.TUESDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_TUESDAY),
                      isNewEntry);
                  break;
                case 2:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.WEDNESDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_WEDNESDAY),
                      isNewEntry);
                  break;
                case 3:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.THURSDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_THURSDAY),
                      isNewEntry);
                  break;
                case 4:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.FRIDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_FRIDAY),
                      isNewEntry);
                  break;
                case 5:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.SATURDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_SATURDAY),
                      isNewEntry);
                  break;
                case 6:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.SUNDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_SUNDAY),
                      isNewEntry);
                  break;
                default:
                  debugPrint(
                      "Error while specifying _tabController.index (FAB -> onPressed -> switch, fullWeek = true)");
              }
            } else {
              switch (_tabController.index) {
                case 0:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.MONDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_MONDAY),
                      isNewEntry);
                  break;
                case 1:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.TUESDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_TUESDAY),
                      isNewEntry);
                  break;
                case 2:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.WEDNESDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_WEDNESDAY),
                      isNewEntry);
                  break;
                case 3:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.THURSDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_THURSDAY),
                      isNewEntry);
                  break;
                case 4:
                  navigationToDetailsView(
                      Lesson("", "", "", "", Constants.FRIDAY_ID),
                      LocalizedText.of(context, Constants.NEW_LESSON_FRIDAY),
                      isNewEntry);
                  break;
                default:
                  debugPrint(
                      "Error while specifying _tabController.index (FAB -> onPressed -> switch)");
              }
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  updateListView(String tab) async {
    switch (tab) {
      case Constants.MONDAY_ID:
        _mondayList = await dataBaseHelper.getModelsFromMapList(tab);
        setState(() {
          mondayListLength = _mondayList.length;
        });
        break;

      case Constants.TUESDAY_ID:
        _tuesdayList = await dataBaseHelper.getModelsFromMapList(tab);
        setState(() {
          tuesdayListLength = _tuesdayList.length;
        });
        break;

      case Constants.WEDNESDAY_ID:
        _wednesdayList = await dataBaseHelper.getModelsFromMapList(tab);
        setState(() {
          wednesdayListLength = _wednesdayList.length;
        });
        break;

      case Constants.THURSDAY_ID:
        _thursdayList = await dataBaseHelper.getModelsFromMapList(tab);
        setState(() {
          thursdayListLength = _thursdayList.length;
        });
        break;

      case Constants.FRIDAY_ID:
        _fridayList = await dataBaseHelper.getModelsFromMapList(tab);
        setState(() {
          fridayListLength = _fridayList.length;
        });
        break;

      case Constants.SATURDAY_ID:
        _saturdayList = await dataBaseHelper.getModelsFromMapList(tab);
        setState(() {
          saturdayListLength = _saturdayList.length;
        });
        break;

      case Constants.SUNDAY_ID:
        _sundayList = await dataBaseHelper.getModelsFromMapList(tab);
        setState(() {
          sundayListLength = _sundayList.length;
        });
        break;

      default:
        /* Updating all the listviews. Needed when the user imports a new timetable from file. */
        _mondayList =
            await dataBaseHelper.getModelsFromMapList(Constants.MONDAY_ID);
        _tuesdayList =
            await dataBaseHelper.getModelsFromMapList(Constants.TUESDAY_ID);
        _wednesdayList =
            await dataBaseHelper.getModelsFromMapList(Constants.WEDNESDAY_ID);
        _thursdayList =
            await dataBaseHelper.getModelsFromMapList(Constants.THURSDAY_ID);
        _fridayList =
            await dataBaseHelper.getModelsFromMapList(Constants.FRIDAY_ID);
        _saturdayList =
            await dataBaseHelper.getModelsFromMapList(Constants.SATURDAY_ID);
        _sundayList =
            await dataBaseHelper.getModelsFromMapList(Constants.SUNDAY_ID);
        setState(() {
          mondayListLength = _mondayList.length;
          tuesdayListLength = _tuesdayList.length;
          wednesdayListLength = _wednesdayList.length;
          thursdayListLength = _thursdayList.length;
          fridayListLength = _fridayList.length;
          saturdayListLength = _saturdayList.length;
          sundayListLength = _sundayList.length;
        });
    }
  }

  NotificationListener populateListView(List lessonList, int listLength) {
    String locationStr;
    String timeSpanStr;
    String subTitleStr;

    Widget subTitleTextField;

    return NotificationListener(
      onNotification: (t) {
        /* when the user finishes a scroll in the listview make the floating action button visible after a delay
         * useful in case the fab would cover the delete button of an item */
        if (t is ScrollEndNotification) {
          Timer(const Duration(milliseconds: 500), () {
            setState(() {
              _fabIsVisible = true;
            });
          });
        }
        return true;
      },
      child: ListView.builder(
        controller: _hideButtonController,
        itemCount: listLength,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          Lesson lesson = lessonList[index];

          locationStr = lesson.location == "" || lesson.location == null
              ? ""
              : lesson.location;

          timeSpanStr = lesson.beginsAt == "" ||
                  lesson.beginsAt == null ||
                  lesson.endsAt == "" ||
                  lesson.endsAt == null
              ? ""
              : lesson.beginsAt + " - " + lesson.endsAt;

          subTitleStr = (locationStr == "" && timeSpanStr == "")
              ? ""
              : (locationStr == ""
                  ? timeSpanStr
                  : (timeSpanStr == ""
                      ? locationStr
                      : locationStr + "\n" + timeSpanStr));

          /* Only show the subtitle of the Card if either locationStr or timeSpanStr are not empty */
          subTitleTextField = subTitleStr == ""
              ? null
              : Text(
                  subTitleStr,
                  style: TextStyle(fontSize: 18),
                );

          return Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Card(
                child: GestureDetector(
                  onTap: () {
                    // disable autofocus on first textfield on lesson manager screen
                    isNewEntry = false;
                    navigationToDetailsView(
                        lesson,
                        LocalizedText.of(context, Constants.EDIT_LESSON_TITLE),
                        isNewEntry);
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      lesson.title,
                      style: TextStyle(
                        fontSize: 25,
                        color: ThemeProvider.listTileTitleColor,
                      ),
                    ),
                    subtitle: subTitleTextField,
                    leading: Icon(
                      Icons.access_time,
                      size: 41,
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.delete,
                        size: 41,
                      ),
                      onTap: () {
                        // Message before deleting an entry
                        showAlertDialog(context, lesson);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  showAlertDialog(BuildContext context, Lesson lesson) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(LocalizedText.of(context, Constants.CANCEL_TEXT)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(LocalizedText.of(context, Constants.DELETE_TEXT)),
      onPressed: () {
        Navigator.of(context).pop();
        deleteItem(lesson);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(LocalizedText.of(context, Constants.DELETE_ALERT_TITLE)),
      content: Text(LocalizedText.of(context, Constants.DELETE_ALERT_CONTENT)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteItem(Lesson lesson) async {
    int result = await dataBaseHelper.delete(lesson);

    if (result != 0) {
      updateListView(lesson.day);
    }
  }

  navigationToDetailsView(
      Lesson lesson, String appBarTitle, bool isNewEntry) async {
    bool results =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LessonManagerScreen(lesson, appBarTitle, isNewEntry);
            })) ??
            false;

    if (results) {
      // update the list
      updateListView(lesson.day);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();

    _hideButtonController.removeListener(_hideButtonWhileScrolling);
    _hideButtonController.dispose();

    super.dispose();
  }
}
