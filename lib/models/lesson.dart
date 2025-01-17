import 'package:timetable_app/utilities/constants.dart' as Constants;

class Lesson {
  int id;
  String title, location, beginsAt, endsAt, day;

  Lesson(this.title, this.location, this.beginsAt, this.endsAt, this.day);

  Lesson.withID(
      this.id, this.title, this.location, this.beginsAt, this.endsAt, this.day);

  // map to model
  Lesson.fromMap(Map<String, dynamic> map) {
    id = map[Constants.ID_COL];
    title = map[Constants.TITLE_COL];
    location = map[Constants.LOCATION_COL];
    beginsAt = map[Constants.BEGINS_COL];
    endsAt = map[Constants.ENDS_COL];
    day = map[Constants.DAY_COL];
  }

  // model to map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();

    if (id != null) map[Constants.ID_COL] = id;

    map[Constants.TITLE_COL] = title;
    map[Constants.LOCATION_COL] = location;
    map[Constants.BEGINS_COL] = beginsAt;
    map[Constants.ENDS_COL] = endsAt;
    map[Constants.DAY_COL] = day;

    return map;
  }

  // model from json
  Lesson.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        location = json["location"],
        beginsAt = json["beginsAt"],
        endsAt = json["endsAt"],
        day = json["day"];

  // json from model
  Map<String, dynamic> toJson() => {
        'id': null,
        'title': title,
        'location': location,
        'beginsAt': beginsAt,
        'endsAt': endsAt,
        'day': day
      };
}