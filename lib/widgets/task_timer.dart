import 'package:flutter/material.dart';

class TaskTimer extends StatelessWidget {
  final Duration duration;
  final double progress;
  final int time;
  final Function timerControlHandler;
  final bool isRunning;

  TaskTimer(this.duration, this.progress, this.time, this.timerControlHandler,
      this.isRunning);

  String get currentTime {
    String timeInMinutes = (time / 60).toStringAsFixed(2);
    int minutes = int.parse(timeInMinutes.split(".")[0]);
    int seconds = (double.parse(timeInMinutes.split(".")[1]) * 0.6).round();

    return '$minutes:$seconds';
  }

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
                Text(
                  currentTime,
                  style: TextStyle(fontSize: 50, color: Colors.white70),
                ),
                IconButton(
                  iconSize: 40,
                  color: Colors.white70,
                  icon: Icon(
                    isRunning ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: timerControlHandler,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
