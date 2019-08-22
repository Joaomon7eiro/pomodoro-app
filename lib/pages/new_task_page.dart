import 'package:flutter/material.dart';
import 'package:pomodoro_app/models/task.dart';

class NewTaskPage extends StatefulWidget {
  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  int rounds = 5;
  int duration = 25;

  TextEditingController textController = TextEditingController();

  void handleRounds(bool isIncrement) {
    setState(() {
      isIncrement ? rounds++ : rounds--;
    });
  }

  void handleDuration(bool isIncrement) {
    setState(() {
      isIncrement ? duration++ : duration--;
    });
  }

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
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    'Nova Tarefa',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: TextField(
                      controller: textController,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Nome da Tarefa',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Número de rodadas',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                'Duração de cada rodada',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 15),
                          color: Colors.grey.shade900,
                          child: IntrinsicWidth(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        handleRounds(true);
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      '$rounds',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        handleRounds(false);
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        handleDuration(true);
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      '$duration',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        handleDuration(false);
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 20),
                    color: Colors.grey.shade900,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'CANCELAR',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Task task = Task(
                                rounds: rounds,
                                duration: duration.toDouble(),
                                name: textController.text,
                                description: 'descricao',
                                date: DateTime.now(),
                                id: '6');
                            Navigator.pushNamed(context, '/', arguments: task);
                          },
                          child: Text(
                            'SALVAR',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
