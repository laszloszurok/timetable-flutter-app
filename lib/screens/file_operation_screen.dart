import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timetable_app/models/lesson_list.dart';
import 'package:timetable_app/utilities/db_helper.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;
import 'package:timetable_app/utilities/localization.dart';

class FileOperationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataBaseHelper dataBaseHelper = DataBaseHelper();
    bool didImport = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context, didImport);
            }),
        title: Text(LocalizedText.of(context).fileOperationsLabel),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      if (await Permission.storage.request().isGranted) {
                        final externalDirectory =
                            await getExternalStorageDirectory();
                        final path =
                            externalDirectory.parent.parent.parent.parent.path;
                        final file =
                            File('$path/${LocalizedText.of(context).exportFileName}');
                        List timetable =
                            await dataBaseHelper.getAllModelsFromMapList();
                        String json = jsonEncode(timetable);
                        file.writeAsStringSync(json);

                        // set up a dialog
                        Widget okButton = FlatButton(
                          child: Text(LocalizedText.of(context).okButtonText),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text(LocalizedText.of(context).exportSuccessTitle),
                          content: Text(
                            "${LocalizedText.of(context).exportSuccessContent}\n${file.path}",
                          ),
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
                      }
                    },
                    child: Text(
                      LocalizedText.of(context).exportButtonText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      if (await Permission.storage.request().isGranted) {
                        File file = await FilePicker.getFile(
                            type: FileType.custom, allowedExtensions: ["json"]);
                        if (file != null) {
                          dataBaseHelper.truncate();
                          String content = file.readAsStringSync();
                          List<dynamic> parsedJson = jsonDecode(content);
                          LessonList lessonList =
                              LessonList.fromJson(parsedJson);
                          List timetable = lessonList.lessons;

                          for (int i = 0; i < timetable.length; i++) {
                            dataBaseHelper.insert(timetable[i]);
                          }
                          didImport = true;

                          // set up a dialog
                          Widget okButton = FlatButton(
                            child: Text(LocalizedText.of(context).okButtonText),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text(LocalizedText.of(context).importSuccessTitle),
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
                        }
                      }
                    },
                    child: Text(
                      LocalizedText.of(context).importButtonText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
