import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/expandable_task.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = [
    Task(
      id: '1',
      name: 'Desenhar',
      rounds: 5,
      duration: 1,
      description: 'Alguma descrição aleatoria sobre uma tarefa',
      date: DateTime.now(),
    ),
    Task(
      id: '2',
      name: 'Cozinhar',
      rounds: 5,
      duration: 30,
      description: 'Alguma descrição aleatoria sobre uma tarefa',
      date: DateTime.now(),
    ),
    Task(
      id: '3',
      name: 'Postar no Youtube Postar no Youtube Postar no Youtube',
      rounds: 3,
      duration: 10,
      description: 'Alguma descrição aleatoria sobre uma tarefa',
      date: DateTime.now(),
    ),
    Task(
      id: '4',
      name: 'Videos novos',
      rounds: 3,
      duration: 30,
      description: 'Alguma descrição aleatoria sobre uma tarefa',
      date: DateTime.now(),
    ),
    Task(
      id: '5',
      name: 'Projeto TCC',
      rounds: 1,
      duration: 30,
      description: 'Alguma descrição aleatoria sobre uma tarefa',
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context).settings.arguments;
    if (task != null && !tasks.contains(task)) {
      tasks.add(task);
    }

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
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 22,
                          fontWeight: FontWeight.bold),
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
                  onPressed: () => Navigator.pushNamed(context, '/new-task'),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ExpandableTask(tasks[index]);
                  },
                  itemCount: tasks.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
