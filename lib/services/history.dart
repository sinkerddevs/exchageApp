import 'package:flutter/material.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(20.0),
            ),
            new Text("ລາຍການທັງໝົດ"),
          ],
        ),
      ),
    );
  }
}
