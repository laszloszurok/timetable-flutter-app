import 'lesson.dart';

/* Used for storing lessons, imported from a JSON file, 
 * until they get inserted into the database. */

class LessonList {
  final List<Lesson> lessons;

  LessonList({
    this.lessons,
  });

  factory LessonList.fromJson(List<dynamic> parsedJson) {
    List<Lesson> lessons = new List<Lesson>();
    lessons = parsedJson.map((i) => Lesson.fromJson(i)).toList();
    return new LessonList(lessons: lessons);
  }
}