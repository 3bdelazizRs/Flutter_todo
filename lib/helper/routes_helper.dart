import 'package:flutter/material.dart';
import 'package:test_todos/view/screens/home_page.dart';

import '../view/screens/splash_screen.dart';
import '../view/screens/add_todo.dart';

class RouterHelper {
  static const initial = "/";
  static const homePage = "/home";
  static const addTodo = "/addTodo";

  static Map<String, Widget Function(BuildContext context)> routes = {
    initial: (context) => const SplashScreen(),
    homePage: (context) => const HomePage(),
    addTodo: (context) => const AddTodo(),
  };
}
