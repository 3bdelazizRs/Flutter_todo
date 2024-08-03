import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_todos/data/model/todomodel.dart';
import 'package:test_todos/utils/string.dart';
import 'package:test_todos/view/screens/add_todo.dart';

import '../../data/db/shared-preferences.dart';
import '../../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  _loadTodos() async {
    String? todoListString = await LocalDb.getTodos;
    if (todoListString != null) {
      List<dynamic> todoListJson = json.decode(todoListString);
      setState(() {
        _todos = todoListJson.map((json) => TodoModel.fromJson(json)).toList();
      });
    }
  }

  _saveTodos() async {
    await LocalDb.storeTodo(_todos);
  }

  _addTodo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodo()),
    );

    if (result != null) {
      setState(() {
        _todos.add(result);
        _saveTodos();
      });
    }
  }

  _toggleTodoCompletion(TodoModel todo) {
    Future.microtask(() {
      setState(() {
        todo.completed = !todo.completed;
        _saveTodos();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(homeTitle,
                      style: GoogleFonts.jost(
                          color: textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500)),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _todos.length,
                        itemBuilder: (context, index) {
                          final todo = _todos[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 2.0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(todo.title,
                                              style: GoogleFonts.jost(
                                                  color: textColor,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600)),
                                          Text(todo.description,
                                              style: GoogleFonts.jost(
                                                  color: Colors.grey,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400))
                                        ]),
                                  ),
                                  Checkbox(
                                      value: todo.completed,
                                      onChanged: (val) {
                                        _toggleTodoCompletion(todo);
                                      })
                                ],
                              ),
                            ),
                          );

                          //  todo_card(
                          //   todo: todo,
                          //   toggleTodoCompletion: _toggleTodoCompletion(todo),
                          // );
                        }),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: GestureDetector(
                onTap: () {
                  _addTodo();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: endColor,
                          spreadRadius: 0,
                          blurRadius: 5.0,
                          offset: Offset(0, 1),
                        ),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[startColor, endColor])),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
