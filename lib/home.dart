import 'package:exchange/setup/createNewUser.dart';
import 'package:exchange/setup/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'exchange.dart';
import 'login.dart';
import './services/calExchange.dart' as calExchange;
import './services/history.dart' as history;
import './services/TodayEX.dart' as todayExchange;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String user1 =
      "https://scontent.fvte3-1.fna.fbcdn.net/v/t1.0-9/66577134_487839871962627_8019323159951966208_n.jpg?_nc_cat=111&_nc_eui2=AeFQ8duBhlKACPBumyadm1u5mJrq4jaSEWJt_366bEUJrJjKv94c3Bl_p7zK2jbHj6T2v2opOOqc-AabMzJJ15hy7sh-g4Vgg0L53dKe7vJyaskGfLqMbywE0ndQmU-6gBs&_nc_oc=AQkApmomqWX8VKTQX2c83UdRjyKyiVn1BZJwsruRH-aJ5Y8HsQDUyNrh2wHMgR2R6p8&_nc_ht=scontent.fvte3-1.fna&oh=33979d9033c889dd2eb3c46cb8143891&oe=5DBD4CF8";
  String user2 =
      "https://scontent.fvte3-1.fna.fbcdn.net/v/t1.0-9/41495196_2210380809219631_4395934164583448576_n.jpg?_nc_cat=101&_nc_eui2=AeFlM-2w5NqgD-poeLVKA7eyIJH0szjrw8-auQqv7S0xNBZxlLPqwrHS0IRD9JXxN1X_VM6B2qL0PBd14la9FuG5Zp1FIGTUFpxtxlWJWmm9LcRZMgzCE2D8Cud_qIqPIsc&_nc_oc=AQl3EHK_ZZbBu3S7qTGh4FCyW400zUNdhnhzqldHEj8mpxgstbNsZK5l-K-aeS43Tvc&_nc_ht=scontent.fvte3-1.fna&oh=ec31663be5dd7df3f40361a530e8b3ef&oe=5D7AFEED";
  String backup;

  String name1 = "ສິນເກີດ ພຸດທະວົງ";
  String email1 = "Sinkerd.dev@gmail.com";
  String name2 = "ມິຣິນດາ ສີຄຳພັນ";
  String email2 = "mirinda.dev@gmail.com";
  String backupname;
  String backupemail;

  void newPerSon() {
    this.setState(() {
      backup = user1;
      user1 = user2;
      user2 = backup;

      backupname = name1;
      name1 = name2;
      name2 = backupname;

      backupemail = email1;
      email1 = email2;
      email2 = backupemail;
    });
  }

  TabController controller;
  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _signout() async {
    await FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/loginGoogle", ModalRoute.withName("/Homrpage"));
    });
  }

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'ທ່ານຕ້ອງການອອກຈາກລະບົບ?',
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  " ຍົກເລີກ",
                  style: TextStyle(color: Colors.blue.withOpacity(1.0)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  " ຢືນຢັນ",
                  style: TextStyle(color: Colors.blue.withOpacity(1.0)),
                ),
                onPressed: () => _signout(),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.lock_outline),
              onPressed: () => _showWarningDialog(context),
            )
          ],
          bottom: new TabBar(
            controller: controller,
            tabs: <Widget>[
              new Tab(
                // icon: new Icon(Icons.calendar_today),
                text: "ອັດຕາແລກປ່ຽນ",
              ),
              new Tab(
                // icon: new Icon(Icons.track_changes),
                text: "ຄິດໄລ່ອັດຕາ",
              ),
              new Tab(
                // icon: new Icon(Icons.history),
                text: "ລາຍການທັງໝົດ",
              ),
            ],
          ),
          title: new Text('ອັດຕາການແລກປ່ຽນເງິນ'),
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(name1),
                accountEmail: new Text(email1),
                currentAccountPicture: new GestureDetector(
                  onTap: () => newPerSon(),
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(user2),
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  new GestureDetector(
                    onTap: () => newPerSon(),
                    child: new CircleAvatar(
                      backgroundImage: new NetworkImage(user1),
                    ),
                  )
                ],
              ),
              new ListTile(
                  title: new Text("ໜ້າຫຼັກ"),
                  trailing: new Icon(Icons.home),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext centext) => new LoginPage()));
                  }),
              new ListTile(
                  title: new Text("ອັດຕາການແລກປ່ຽນ"),
                  trailing: new Icon(Icons.attach_money),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext centext) =>
                            new Exchange("ອັດຕາການແລກປ່ຽນ")));
                  }),
              new ListTile(
                  title: new Text("ການຕັ້ງຄ່າ"),
                  trailing: new Icon(Icons.settings),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext centext) =>
                            new Exchange("ອັດຕາການແລກປ່ຽນ")));
                  }),
              new ListTile(
                  title: new Text("ລົງທະບຽນ"),
                  trailing: new Icon(Icons.offline_pin),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext centext) => new Signin()));
                  }),
              new ListTile(
                  title: new Text("ເພີ່ມຜູ່ໃຊ້"),
                  trailing: new Icon(Icons.assignment_ind),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext centext) =>
                            new CreateNewUser()));
                  }),
              new ListTile(
                  title: new Text("ຜູ່ໃຊ້ພາຍໃນລະບົບ"),
                  trailing: new Icon(Icons.supervised_user_circle),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/showUser');
                    ;
                  }),
              new Divider(),
              new ListTile(
                title: new Text("ປິດ"),
                trailing: new Icon(Icons.close),
                onTap: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new todayExchange.TodayExchange(),
            new calExchange.CalExchange(),
            new history.History(),
          ],
        ),
        bottomNavigationBar: new Material(
          color: Colors.deepOrangeAccent[700],
          child: new TabBar(
            controller: controller,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(Icons.calendar_today),
              ),
              new Tab(
                icon: new Icon(Icons.track_changes),
              ),
              new Tab(
                icon: new Icon(Icons.history),
              ),
            ],
          ),
        ));
  }
}
