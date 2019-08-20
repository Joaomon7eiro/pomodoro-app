import 'package:flutter/foundation.dart';

class Task {
  String id;
  String name;
  int rounds;
  double duration;
  String description;
  DateTime date;

  Task(
      {@required this.id,
      @required this.name,
      @required this.rounds,
      @required this.duration,
      this.description,
      this.date});
}
