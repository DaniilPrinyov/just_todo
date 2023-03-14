import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_todo/internal/model/to_do_card_model.dart';

class ToDoCardAdapter extends TypeAdapter<ToDoCardModel> {
  @override
  final typeId = 0;

  @override
  ToDoCardModel read(BinaryReader reader) {
    final isComplete = reader.readBool();
    final toDoText = reader.readString();

    return ToDoCardModel(isComplete: isComplete, toDoText: toDoText);
  }

  @override
  void write(BinaryWriter writer, ToDoCardModel obj) {
    writer.writeBool(obj.isComplete);
    writer.writeString(obj.toDoText);
  }
}
