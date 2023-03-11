import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_todo/internal/model/to_do_card_model.dart';

class HiveStorage {
  Future<void> add(String toDoText, {bool isComplete = true}) async {
    final box = await Hive.openBox<ToDoCardModel>('ToDoInfo');
    await box.add(
      ToDoCardModel(toDoText: toDoText, isComplete: isComplete),
    );
    await box.close();
  }

  Future<void> kill(int index) async {
    final box = await Hive.openBox<ToDoCardModel>('ToDoInfo');
    await box.deleteAt(index);
    await box.close();
  }

  Future<ToDoCardModel> get(int index) async {
    final box = await Hive.openBox<ToDoCardModel>('ToDoInfo');
    final result =
        box.getAt(index) ?? ToDoCardModel(toDoText: "error", isComplete: false);
    await box.close();
    return result;
  }

  Future<int> length() async {
    final box = await Hive.openBox<ToDoCardModel>('ToDoInfo');
    final int result = box.length;
    await box.close();
    return result;
  }
}
