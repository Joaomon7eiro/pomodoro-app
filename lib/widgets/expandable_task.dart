import 'package:flutter/material.dart';
import '../models/task.dart';

class ExpandableTask extends StatefulWidget {
  final Task task;

  ExpandableTask(this.task);

  @override
  _ExpandableTaskState createState() => _ExpandableTaskState();
}

class _ExpandableTaskState extends State<ExpandableTask> {
  bool isExpanded = false;

  void toggleTask() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? InkWell(
            child: _ExpandedTask(widget.task),
            onTap: toggleTask,
          )
        : InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 50, top: 30),
              child: Row(
                children: <Widget>[
                  Text(
                    widget.task.id,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      widget.task.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: toggleTask,
          );
  }
}

class _ExpandedTask extends StatelessWidget {
  final Task task;

  _ExpandedTask(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      color: Colors.grey.shade900,
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    task.id,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Container(
                  color: Colors.black,
                  width: 60,
                  height: 60,
                  child: InkWell(
                    child: Icon(
                      Icons.play_arrow,
                      size: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/execute-task',
                          arguments: task);
                    },
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            task.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        IconButton(
                          color: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        )
                      ],
                    ),
                    margin: EdgeInsets.all(15),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '0/${task.rounds} rodadas de ${task.duration} min',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '22/08/2019',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
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
