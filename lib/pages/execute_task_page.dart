import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:quiver/async.dart';

class ExecuteTaskPage extends StatefulWidget {
  @override
  _ExecuteTaskPageState createState() => _ExecuteTaskPageState();
}

class _ExecuteTaskPageState extends State<ExecuteTaskPage> {
  Task task;
  double progress = 0;
  CountdownTimer countdownTimer;

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context).settings.arguments;
    Duration duration = Duration(minutes: task.duration.toInt());

    if (countdownTimer == null) {
      countdownTimer = CountdownTimer(duration, Duration(seconds: 1));
      countdownTimer.listen((timer) {
        setState(() {
          progress =
              1 - (countdownTimer.remaining.inSeconds / duration.inSeconds);
        });
      });
    }

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
                    countdownTimer.cancel();
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
            Container(
                margin: EdgeInsets.only(top: 60),
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          backgroundColor: Colors.black,
                          value: progress,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Countdown(
                            duration: duration,
                            onFinish: () {
                              print('finished!');
                            },
                            builder: (BuildContext ctx, Duration remaining) {
                              duration = remaining;
                              String sec =
                                  (duration.inSeconds / 60).toStringAsFixed(2);
                              int seconds =
                                  (double.parse(sec.split(".")[1]) * 0.6)
                                      .round();
                              return Text(
                                '${remaining.inMinutes}:$seconds',
                                style: TextStyle(fontSize: 50),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.pause),
                            onPressed: () {
                              setState(() {
                                progress += 0.1;
                                print(progress);
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
