import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_with_hive/data/database.dart';
import 'package:todo_with_hive/util/dialog_box.dart';
import 'package:todo_with_hive/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  late final TextEditingController _dialogController;

  @override
  void initState() {
    super.initState();
    _dialogController = TextEditingController();
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  @override
  void dispose() {
    _dialogController.clear();
    super.dispose();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.yellow[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewTask();
        },
        child: const Icon(Icons.add),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (db.toDoList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create note',
              style: TextStyle(
                fontSize: 40,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            Icon(
              Icons.edit_note,
              size: 120,
              color: Colors.grey,
            ),
            Text(
              'tap " + "',
              style: TextStyle(
                fontSize: 40,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoTile(
            nameTask: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => _deleteTask(index),
          );
        },
      );
    }
  }

  void _createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _dialogController,
            onCancel: () => Navigator.of(context).pop(),
            onSave: _saveNewTask,
          );
        });
  }

  void _saveNewTask() {
    setState(() {
      db.toDoList.add([_dialogController.text, false]);
      _dialogController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void _deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }
}
