import 'package:flutter/material.dart';
import 'dart:core';

class CounterPage extends StatefulWidget {
  CounterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  static DateTime _newYear = new DateTime(2021, 1, 1, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: Stream.periodic(Duration(seconds: 1), (i) => i),
                builder: (context, snapshot) {
                  DateTime now = new DateTime.now();
                  int remaining = _newYear.difference(now).inSeconds;
                  int days = remaining ~/ 86400;
                  int hours = remaining % 86400 ~/ 3600;
                  int minutes = remaining % 86400 % 3600 ~/ 60;
                  int seconds = remaining % 86400 % 3600 % 60;
                  if (remaining <= 0) {
                    return Column(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "It's Over!",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Text(
                        "🥳",
                        style: Theme.of(context).textTheme.headline1.merge(
                            TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                      )
                    ]);
                  }
                  return Column(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        '2020 will be over in',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Text(
                      '$days Days',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '$hours Hours',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '$minutes Minutes',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '$seconds Seconds',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ]);
                }),
          ],
        ),
      ),
    );
  }
}
