import 'package:flutter/cupertino.dart';

class TodayExchange extends StatefulWidget {
  TodayExchange({Key key}) : super(key: key);

  _TodayExchangeState createState() => _TodayExchangeState();
}

class _TodayExchangeState extends State<TodayExchange> {
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
            new Text("ອັດຕາແລກປ່ຽນປະຈຳວັນ"),
          ],
        ),
      ),
    );
  }
}
