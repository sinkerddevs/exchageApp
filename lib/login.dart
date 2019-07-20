import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding:
            EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0, bottom: 10.0),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/flutter.jpeg',
              width: 100.0,
              height: 100.0,
            ),
            SizedBox(height: 20.0),
            Text(
              "ເຂົ້າສູ່ລະບົບ",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            buildTextFieldEmail("ອີເມວ"),
            SizedBox(
              height: 10.0,
            ),
            buildTextFieldPassword("ລະຫັດຜ່ານ"),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "ລືມລະຫັດຜ່ານຂອງທ່ານ?",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            new GestureDetector(
                onTap: () {
                  // FirebaseAuth.instance
                  //     .signInWithEmailAndPassword(
                  //   email: _email,
                  //   password: _password,
                  // )
                  //     .then((FirebaseUser user) {
                  //   Navigator.of(context).pushReplacementNamed('/Homepage');
                  // }).catchError((e) {
                  //   print(e);
                  // });
                  try {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    Navigator.of(context).pushReplacementNamed('/Homepage');
                  } catch (e) {
                    print(e);
                  }
                  // FirebaseAuth.instance.signInWithEmailAndPassword(
                  //     email: _email, password: _password);
                  // if (_email == "sinkerd@gmail.com" &&
                  //     _password == "12345678") {
                  //   Navigator.of(context).pushReplacementNamed('/Homepage');
                  // }
                },
                child: new Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      gradient: LinearGradient(
                          colors: [Color(0xFF009688), Color(0xFF4DB6AC)],
                          begin: Alignment.centerRight,
                          end: Alignment.bottomLeft)),
                  child: Center(
                    child: new Text(
                      "ເຂົ້າສູ່ລະບົບ",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                )),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("ທ່ານມີບັນຊີແລ້ວ ຫຼື ບໍ ?"),
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text(
                        "ລົງທະບຽນ",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldEmail(String hintText) {
    return new TextField(
        onChanged: (value) {
          setState(() {
            _email = value;
          });
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
          prefixIcon: Icon(Icons.email),
        ));
  }

  Widget buildTextFieldPassword(String hintText) {
    return new TextField(
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
      obscureText: true,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: hintText == "ລະຫັດຜ່ານ"
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.visibility_off),
                )
              : Container()),
    );
  }

  Widget builButtonContainer() {}
}
