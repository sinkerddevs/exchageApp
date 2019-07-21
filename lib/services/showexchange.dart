import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class ShowExchage extends StatefulWidget {
  @override
  _ShowExchageState createState() => _ShowExchageState();
}
 class User{
  final String userID;
  final String name;
  final String email;
  final String password;
  final String age;
  User(this.userID,this.email,this.age,this.password,this.name);

}
class _ShowExchageState extends State<ShowExchage> {
 
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("ສະແດງ user"),
      ),
      body: new Container(
        child: FutureBuilder(
      
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
