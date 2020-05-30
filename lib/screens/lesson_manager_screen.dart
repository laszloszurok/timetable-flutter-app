import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:timetable_app/models/lesson.dart';
import 'package:timetable_app/utilities/db_helper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;

class LessonManagerScreen extends StatefulWidget {
  final Lesson lesson;
  final String appBarTitle;
  final bool isNewEntry;

  LessonManagerScreen(this.lesson, this.appBarTitle, this.isNewEntry);
  @override
  _LessonManagerScreenState createState() =>
      _LessonManagerScreenState(this.lesson, this.appBarTitle, this.isNewEntry);
}

class _LessonManagerScreenState extends State<LessonManagerScreen> {
  Lesson lesson;
  String appBarTitle;
  String _day;
  bool isNewEntry;

  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _locationEditingController = TextEditingController();
  TextEditingController _beginsAtEditingController = TextEditingController();
  TextEditingController _endsAtEditingController = TextEditingController();

  _LessonManagerScreenState(this.lesson, this.appBarTitle, this.isNewEntry);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _titleEditingController.text = lesson.title;
    _locationEditingController.text = lesson.location;
    _beginsAtEditingController.text = lesson.beginsAt;
    _endsAtEditingController.text = lesson.endsAt;
    _day = lesson.day;

    final format = DateFormat(Constants.TIME_FORMAT);

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _titleEditingController,
              autofocus: isNewEntry,
              decoration: InputDecoration(
                icon: Icon(
                  (Icons.library_books),
                ),
                hintText: Constants.NEW_ENTRY_TITLE_HINT,
                labelText: Constants.NEW_ENTRY_TITLE_HINT,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _locationEditingController,
              decoration: InputDecoration(
                icon: Icon((Icons.place)),
                hintText: Constants.NEW_ENTRY_LOCATION_HINT,
                labelText: Constants.NEW_ENTRY_LOCATION_HINT,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DateTimeField(
              controller: _beginsAtEditingController,
              decoration: InputDecoration(
                icon: Icon(Icons.access_time),
                hintText: Constants.NEW_ENTRY_BEGINS_HINT,
                labelText: Constants.NEW_ENTRY_BEGINS_HINT,
                border: OutlineInputBorder(),
              ),
              format: format,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
            ),
            SizedBox(
              height: 20,
            ),
            DateTimeField(
              controller: _endsAtEditingController,
              decoration: InputDecoration(
                icon: Icon(Icons.access_time),
                hintText: Constants.NEW_ENTRY_ENDS_HINT,
                labelText: Constants.NEW_ENTRY_ENDS_HINT,
                border: OutlineInputBorder(),
              ),
              format: format,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      validate();
                    },
                    child: Text(
                      Constants.SAVE_BUTTON_TEXT,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  validate() {
    if (_titleEditingController.text == "" ||
        _titleEditingController.text == null) {
      Widget okButton = FlatButton(
        child: Text(Constants.OK_BUTTON_TEXT),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text(Constants.REQUIRE_TITLE_ALERT_TEXT),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return;
    }

    lesson.title = _titleEditingController.text;
    lesson.location = _locationEditingController.text;
    lesson.beginsAt = _beginsAtEditingController.text;
    lesson.endsAt = _endsAtEditingController.text;
    lesson.day = _day;

    DataBaseHelper dataBaseHelper = DataBaseHelper();

    if (lesson.id == null)
      dataBaseHelper.insert(lesson);
    else
      dataBaseHelper.updateItem(lesson);

    Navigator.pop(context, true);
  }
}
