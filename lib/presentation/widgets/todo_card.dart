import 'package:flutter/material.dart';
import 'package:just_todo/internal/model/to_do_card_model.dart';

// ignore: must_be_immutable
class ToDoCardWidget extends StatefulWidget {
  ToDoCardWidget({
    super.key,
    required this.toDoObject,
    required this.deleteFunc,
  });

  ToDoCardModel toDoObject;
  Function(BuildContext)? deleteFunc;

  @override
  State<ToDoCardWidget> createState() => _ToDoCardWidgetState();
}

class _ToDoCardWidgetState extends State<ToDoCardWidget> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = widget.toDoObject.isComplete;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                fillColor: MaterialStateProperty.all(Colors.white),
                checkColor: Colors.black,
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    print(isChecked);
                    isChecked = value ?? false;
                    print(isChecked);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: LimitedBox(
                  maxWidth: MediaQuery.of(context).size.width - 130,
                  maxHeight: MediaQuery.of(context).size.height / 3,
                  child: Text(
                    widget.toDoObject.toDoText,
                    maxLines: 5,
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white,
                      fontSize: 25,
                      overflow: TextOverflow.ellipsis,
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => widget.deleteFunc!(context),
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
