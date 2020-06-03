import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:timetable_app/models/lesson.dart';
import 'package:timetable_app/utilities/db_helper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;
import 'package:timetable_app/utilities/localization.dart';

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
                hintText: LocalizedText.of(context).newEntryTitleHint,
                labelText: LocalizedText.of(context).newEntryTitleHint,
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
                hintText: LocalizedText.of(context).newEntryLocationHint,
                labelText: LocalizedText.of(context).newEntryLocationHint,
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
                hintText: LocalizedText.of(context).newEntryBeginsHint,
                labelText: LocalizedText.of(context).newEntryBeginsHint,
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
                hintText: LocalizedText.of(context).newEntryEndsHint,
                labelText: LocalizedText.of(context).newEntryEndsHint,
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
                      LocalizedText.of(context).saveButtonText,
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
        child: Text(LocalizedText.of(context).okButtonText),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text(LocalizedText.of(context).requireTitleAlertText),
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
