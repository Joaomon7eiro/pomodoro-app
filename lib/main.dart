import 'package:flutter/material.dart';

import './pages/new_task_page.dart';
import './pages/task_list_page.dart';
import './pages/execute_task_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro App',
      initialRoute: '/',
      routes: {
        '/': (context) => TaskListPage(),
        '/new-task': (context) => NewTaskPage(),
        '/execute-task': (context) => ExecuteTaskPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}
