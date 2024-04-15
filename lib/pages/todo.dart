import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/components/to_do_list.dart';
import 'package:todo/data/database.dart';

import '../components/dialog_box.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({
    super.key,
  });

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  ToDoDataBase db = ToDoDataBase();
  // reference the hive box
  final _myBox = Hive.box('mybox');
  bool check = false;
  final _controller = TextEditingController();

  @override
  void initState() {
    //if this is the first time opening the app create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // there already exist data
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    if (_controller.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text('Please make sure a valid text'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Okay'))
              ],
            );
          });
      return;
    }

    setState(() {
      db.toDoList.add([_controller.text, check]);
      _controller.clear();
    });
    Navigator.pop(context);
    db.updateDataBase();
  }

  void createTask() {
    showDialog(
        context: context,
        builder: (_) {
          return DialogBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.up,
      backgroundColor: Colors.deepPurple[400],
      duration: const Duration(seconds: 3),
      content: const Text('Task has been deleted'),
    ));
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Text(
          'TO DO',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[100],
        onPressed: createTask,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (_, index) {
          return ToDoTile(
              deleteItme: (context) => deleteTask(index),
              taskName: db.toDoList[index][0],
              taskCompeletd: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index));
        },
      ),
    );
  }
}
