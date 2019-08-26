import 'package:flutter/material.dart';
import 'package:pomodoro_app/widgets/task_timer.dart';

import 'package:quiver/async.dart';
import 'package:audioplayers/audio_cache.dart';

import '../models/task.dart';

const pauseDuration = Duration(minutes: 5);

class ExecuteTaskPage extends StatefulWidget {
  @override
  _ExecuteTaskPageState createState() => _ExecuteTaskPageState();
}

class _ExecuteTaskPageState extends State<ExecuteTaskPage> {
  int taskRounds;
  Duration taskDuration;

  Duration currentDuration;

  int time;
  double progress = 0;
  int currentRound = 1;

  CountdownTimer countdownTimer;
  bool needsPause = true;
  bool isRunning = true;

  static AudioCache player = AudioCache();

  void startCountdown(Duration duration) {
    countdownTimer = CountdownTimer(duration, Duration(seconds: 1));
    countdownTimer.listen((timer) {
      setState(() {
        progress = 1 -
            (countdownTimer.remaining.inSeconds / currentDuration.inSeconds);
        time = countdownTimer.remaining.inSeconds + 1;
      });
      if (time == 1 && countdownTimer.remaining.inSeconds == 0) {
        onTaskFinished();
        player.play('alert.wav');
        setState(() {
          time = 0;
        });
      }
    });
  }

  void onTaskFinished() {
    if (currentRound == taskRounds) {
      print('terminou tudo');
      return;
    }

    if (needsPause) {
      setState(() {
        startCountdown(pauseDuration);
      });
      currentDuration = pauseDuration;
      needsPause = false;
    } else {
      setState(() {
        startCountdown(taskDuration);
        currentRound++;
      });
      currentDuration = taskDuration;
      needsPause = true;
    }
  }

  void timerControlHandler() {
    if (isRunning) {
      countdownTimer.cancel();
      isRunning = false;
    } else {
      startCountdown(Duration(seconds: time));
      isRunning = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final Task task = ModalRoute.of(context).settings.arguments;
    Duration duration = Duration(minutes: task.duration.toInt());
    taskRounds = task.rounds;
    taskDuration = duration;

    if (countdownTimer == null) {
      time = duration.inSeconds;
      startCountdown(duration);
      currentDuration = duration;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(top: mediaQuery.padding.top + 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    countdownTimer.cancel();
                    player.clearCache();
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Pomodoro',
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
            isLandscape
                ? SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            TaskTimer(duration, progress, time,
                                timerControlHandler, isRunning),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(vertical: 20),
                              color: Colors.grey.shade900,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '$currentRound/${task.rounds}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    width: mediaQuery.size.width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Se você quer isso, lute por isso.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width:
                                                  mediaQuery.size.width * 0.4,
                                              child: Text(
                                                task.name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Text(
                                              '${task.duration.toString()} min',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: BorderDirectional(
                              start: BorderSide(
                                  color: Colors.grey.shade900, width: 3),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Desc',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(task.description)
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Data',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 23,
                                  ),
                                  Text(task.date.toString())
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 50,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TaskTimer(duration, progress, time,
                              timerControlHandler, isRunning),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(vertical: 20),
                            color: Colors.grey.shade900,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  '$currentRound/${task.rounds}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                Container(
                                  width: mediaQuery.size.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Se você quer isso, lute por isso.',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: mediaQuery.size.width * 0.4,
                                            child: Text(
                                              task.name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Text(
                                            '${task.duration.toString()} min',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                start: BorderSide(
                                    color: Colors.grey.shade900, width: 3),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Desc',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(task.description)
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Data',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 23,
                                    ),
                                    Text(task.date.toString())
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
