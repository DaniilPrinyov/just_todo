import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ToDoCard extends StatefulWidget {
  ToDoCard({
    super.key,
    required this.toDoText,
    required this.deleteFunc,
  });

  String toDoText;
  Function(BuildContext)? deleteFunc;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Checkbox(
            fillColor: MaterialStateProperty.all(Colors.white),
            checkColor: Colors.black,
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 130,
              maxHeight: MediaQuery.of(context).size.height / 3,
              child: Text(
                widget.toDoText,
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
