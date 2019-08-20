import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/expandable_task.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = [
    Task(id: '1', name: 'Desenhar', rounds: 5, duration: 1),
    Task(id: '2', name: 'Cozinhar', rounds: 5, duration: 30),
    Task(
        id: '3',
        name: 'Postar no Youtube Postar no Youtube Postar no Youtube',
        rounds: 5,
        duration: 30),
    Task(id: '4', name: 'Videos novos', rounds: 5, duration: 30),
    Task(id: '5', name: 'Projeto TCC', rounds: 5, duration: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'Lista de Tarefas',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                FlatButton(
                  color: Colors.grey.shade900,
                  child: Text(
                    'Adicionar Novo',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8972,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ExpandableTask(tasks[index]);
                },
                itemCount: tasks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
