import 'package:flutter/material.dart';
import 'package:just_todo/data/hive_storage.dart';
import 'package:just_todo/internal/model/to_do_card_model.dart';
import 'package:just_todo/presentation/widgets/todo_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

TextEditingController textController = TextEditingController();

class _MainScreenState extends State<MainScreen> {
  void deleteTask(int index) {
    setState(() {
      HiveStorage().kill(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Add tasks'),
            content: TextField(
              maxLines: 2,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(),
                border: OutlineInputBorder(),
              ),
              controller: textController,
              cursorColor: Colors.black,
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.grey[300]),
                ),
                onPressed: () {
                  textController.text = "";
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.grey[300]),
                ),
                onPressed: () {
                  setState(() {
                    HiveStorage().add(textController.text);
                  });
                  textController.text = "";
                  Navigator.pop(context, 'Add');
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Just ToDo",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: HiveStorage().length(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data,
            itemBuilder: (context, index) => FutureBuilder(
              future: HiveStorage().get(index),
              builder: (context, snapshot) {
                return ToDoCardWidget(
                  toDoObject: snapshot.data ??
                      ToDoCardModel(
                        toDoText: "Добавьте первую запись",
                        isComplete: false,
                      ),
                  deleteFunc: (context) => deleteTask(index),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
