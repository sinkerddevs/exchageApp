import 'package:exchange/home.dart';
import 'package:exchange/login.dart';
import 'package:exchange/pages/user.dart';
import 'package:exchange/setup/createNewUser.dart';
import 'package:exchange/setup/loginGoogle.dart';
import 'package:exchange/setup/resetPassword.dart';
import 'package:exchange/setup/signin.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          primaryColor: Colors.red,
          accentColor: Colors.white),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new MyLoginPage(),
        '/signup': (BuildContext context) => new Signin(),
        '/Homepage': (BuildContext context) => new Home(),
        '/login': (BuildContext context) => new LoginPage(),
        '/loginGoogle': (BuildContext context) => new MyLoginPage(),
        '/createUser': (BuildContext context) => new CreateNewUser(),
        '/showUser': (BuildContext context) => new ShowUser(),
        '/resetpassword': (BuildContext context) => new ResetPassword()
      },
    );
  }
}
