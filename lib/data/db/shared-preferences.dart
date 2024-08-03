import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_todos/data/model/todomodel.dart';

class LocalDb {
  static String todoListKey = "todoList";

  // Get Todo List
   static Future<String?> get getTodos async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todoListString = prefs.getString(todoListKey);
    return todoListString;
  }

  // Set Todo List 
  static Future<void> storeTodo(List<TodoModel> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String todoListString =
        json.encode(value.map((todo) => todo.toJson()).toList());
    prefs.setString(todoListKey, todoListString);
  }

}
