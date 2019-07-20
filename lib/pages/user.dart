import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ShowUser extends StatefulWidget {
  ShowUser({Key key}) : super(key: key);

  _ShowUserState createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  Future<List<User>> _getUsers() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2");

    var jsonData = json.decode(data.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user =
          User(u["index"], u["name"], u["age"], u["email"], u["picture"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('ຜູ່ໃຊ້ທັງໝົດໃນລະບົບ'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: new Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("ກຳລັງໂຫຼດ...."),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data[index].picture),
                    ),
                    subtitle: Text(snapshot.data[index].email),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class User {
  final int index;
  final String name;
  final int age;
  final String email;
  final String picture;

  User(this.index, this.name, this.age, this.email, this.picture);
}
