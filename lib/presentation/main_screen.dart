import 'package:flutter/material.dart';
import 'package:just_todo/presentation/widgets/todo_card.dart';

List<String> toDoList = [];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

TextEditingController textController = TextEditingController();

class _MainScreenState extends State<MainScreen> {
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
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
                    toDoList.add(textController.text);
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
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) => ToDoCard(
          toDoText: toDoList[index],
          deleteFunc: (context) => deleteTask(index),
        ),
      ),
    );
  }
}
