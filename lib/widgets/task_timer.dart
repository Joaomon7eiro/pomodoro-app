import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

class TaskTimer extends StatelessWidget {
  final Duration duration;
  final double progress;

  TaskTimer(this.duration, this.progress);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.white70,
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
                    String sec = (remaining.inSeconds / 60).toStringAsFixed(2);
                    int seconds =
                        (double.parse(sec.split(".")[1]) * 0.6).round();
                    return Text(
                      '${remaining.inMinutes}:$seconds',
                      style: TextStyle(fontSize: 50, color: Colors.white70),
                    );
                  },
                ),
                IconButton(
                  iconSize: 40,
                  color: Colors.white70,
                  icon: Icon(
                    Icons.pause,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
