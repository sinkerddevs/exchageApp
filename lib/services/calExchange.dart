import 'package:flutter/material.dart';

class CalExchange extends StatefulWidget {
  CalExchange({Key key}) : super(key: key);

  _CalExchangeState createState() => _CalExchangeState();
}

class _CalExchangeState extends State<CalExchange> {
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
            new Text("ຄິດໄລ່ອັດຕາການແລກປ່ຽນ"),
          ],
        ),
      ),
    );
  }
}
