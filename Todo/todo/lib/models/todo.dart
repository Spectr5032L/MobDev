import 'dart:convert';

class ToDo {
  String id;
  String todoText;
  String? description;
  bool isDone;

  ToDo({ 
    required this.id,
    required this.todoText,
    this.description,
    this.isDone = false,
  });

  factory ToDo.fromJson(String jsonStr) { 
    final Map<String, dynamic> json = jsonDecode(jsonStr);

    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      description: json['description'],
      isDone: json['isDone'],
    );
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'todoText': todoText,
      'description': description,
      'isDone': isDone,
    });
  }
}
