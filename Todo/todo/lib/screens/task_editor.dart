import 'package:flutter/material.dart';

import '../models/todo.dart';

class TaskEditor extends StatefulWidget {
  final ToDo? task; 
  final Function(ToDo) onSave;

  TaskEditor({this.task, required this.onSave}); 

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  late TextEditingController _titleController; 
  late TextEditingController _descriptionController;
  bool isNew = true;

  @override
  void initState() { 
    super.initState();
    isNew = widget.task == null;
    _titleController = TextEditingController(text: widget.task?.todoText ?? ""); 
    _descriptionController = TextEditingController(text: widget.task?.description ?? "");
  }

  void _saveTask() {
    if (_titleController.text.isNotEmpty) {
      widget.onSave(ToDo(
        id: widget.task?.id ?? DateTime.now().toString(),
        todoText: _titleController.text,
        description: _descriptionController.text,
        isDone: widget.task?.isDone ?? false, 
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(isNew ? "Добавить задачу" : "Редактировать задачу"),
        actions: [
          if (!isNew)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Navigator.pop(context, "delete");
              },
            ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Наименование"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Описание"),
            ),
            Spacer(), 
            ElevatedButton(
              onPressed: _saveTask,
              child: Text("Сохранить"),
            ),
          ],
        ),
      ),

    );
  }
}
