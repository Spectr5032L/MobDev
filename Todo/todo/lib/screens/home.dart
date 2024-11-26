import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import 'task_editor.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<ToDo> _todosList = [];
  List<ToDo> _filteredToDo = [];
  bool _showCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadToDoList();
  }

Future<void> _loadToDoList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedTodos = prefs.getString('todos');
  
  if (savedTodos != null) {
    try {
      List<dynamic> decodedTodos = jsonDecode(savedTodos);
      setState(() {
        _todosList = decodedTodos.map((item) => ToDo.fromJson(item)).toList();
        _updateFilter();
      });
    } catch (e) {
      print('Ошибка при загрузке данных: $e');
      _todosList = [];
      _saveToDoList();
    }
  }
}


  Future<void> _saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedTodos = jsonEncode(_todosList.map((item) => item.toJson()).toList());
    await prefs.setString('todos', encodedTodos);
  }

  void _updateFilter() {
    setState(() {
      if (_showCompleted) {
        _filteredToDo = _todosList.where((task) => task.isDone).toList();
      } else {
        _filteredToDo = _todosList.where((task) => !task.isDone).toList();
      }
    });
  }

  void _addOrUpdateTask(ToDo task) {
    setState(() {
      int index = _todosList.indexWhere((t) => t.id == task.id);
      if (index >= 0) {
        _todosList[index] = task; 
      } else {
        _todosList.add(task);
      }
      _saveToDoList();
      _updateFilter();
    });
  }

  void _deleteTask(String id) {
    setState(() {
      _todosList.removeWhere((task) => task.id == id);
      _saveToDoList();
      _updateFilter();
    });
  }

  void _markTaskComplete(ToDo task) {
    setState(() {
      task.isDone = !task.isDone;
      _saveToDoList();
      _updateFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
        backgroundColor: tdBlue,
        actions: [
          IconButton(
            icon: Icon(_showCompleted ? Icons.check_box : Icons.check_box_outline_blank),
            onPressed: () {
              setState(() {
                _showCompleted = !_showCompleted;
                _updateFilter();
              });
            },
          ),
        ],
      ),
      backgroundColor: tdBGColor,
      body: _filteredToDo.isEmpty
          ? const Center(
              child: Text(
                'Задачи отсутсвуют',
                style: TextStyle(fontSize: 18, color: tdGrey),
              ),
            )
          : ListView.builder(
              itemCount: _filteredToDo.length,
              itemBuilder: (context, index) {
                return ToDoItem(
                  todo: _filteredToDo[index],
                  onMarkComplete: _markTaskComplete,
                  onEditItem: (task) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TaskEditor(
                        task: task,
                        onSave: _addOrUpdateTask,
                      ),
                    ),
                  ),
                  onDeleteItem: _deleteTask,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TaskEditor(
                onSave: _addOrUpdateTask,
              ),
            ),
          );
        },
        backgroundColor: tdBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
