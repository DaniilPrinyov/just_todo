import 'package:hive_flutter/hive_flutter.dart';

class ToDoCardModel extends HiveObject {
  String toDoText;
  bool isComplete;

  ToDoCardModel({
    required this.toDoText,
    required this.isComplete,
  });
}
