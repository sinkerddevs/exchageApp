import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signin extends StatefulWidget {
  Signin({Key key}) : super(key: key);

  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formkey = GlobalKey<FormState>();
  String _email, _password;
  final TextEditingController _passwordTextController = TextEditingController();

  // Future<void> signIn_firebase() async {
  //   if (_formkey.currentState.validate()) {
  //     _formkey.currentState.save();
  //     try {
  //       FirebaseUser user = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: _email, password: _password);
  //       Navigator.of(context).pushNamed('/Homepage');
  //     } catch (e) {
  //       print(e.message);
  //     }
  //   }
  // }
  Future<void> signUp_firebase() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        user.sendEmailVerification();
        Navigator.of(context).pushNamed('/loginGoogle');
      } catch (e) {
        print(e.message);
      }
    } else {
      _showWarningDialog(context);
    }
  }

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'ການດຳເນີນການລົ້ມເຫຼວ',
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
            content: Text('ກະລຸນາປ້ອນອີເມວ ແລະ ລະຫັດຜ່ານໃຫ້ຖືກຕ້ອງ'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "ລົງທະບຽນ",
                  style: TextStyle(color: Colors.blue.withOpacity(1.0)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                    key: _formkey,
                    child: new ListView(
                      children: <Widget>[
                        logo(),
                        new Container(
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "ລົງທະບຽນເປັນສະມາຊິກ",
                                  style: TextStyle(
                                      fontSize: 23.0,
                                      color: Colors.redAccent[700]),
                                ),
                                SizedBox(
                                  height: 10.0,
                                )
                              ],
                            ),
                          ),
                        ),
                        buildEmailField(),
                        SizedBox(
                          height: 5.0,
                        ),
                        buildpassField(),
                        SizedBox(
                          height: 5.0,
                        ),
                        confirmPassword(),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton.icon(
                          label: Text(
                            "ລົງທະບຽນ",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          colorBrightness: Brightness.dark,
                          color: Colors.red,
                          icon: Icon(Icons.border_color),
                          onPressed: () => signUp_firebase(),
                        )
                      ],
                    )))));
  }

  Container logo() {
    return Container(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 98.0, left: 98.0),
      child: Image.asset('assets/ltc.png'),
    );
  }

  Widget buildEmailField() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "ອີເມວ",
          hintText: "ກະລຸນາປ້ອນອີເມວຂອງທ່ານ",
          fillColor: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _email = value,
      autovalidate: true,
      validator: (String value) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);

        if (value.isEmpty || !regex.hasMatch(value)) {
          return "ກະລຸນາປ້ອນອີເມວຂອງທ່ານໃຫ້ຖືກຕ້ອງ";
        }
      },
    );
  }

  Widget buildpassField() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "ລະຫັດຜ່ານ",
          hintText: "ກະລຸນາປ້ອນລະຫັດຜ່ານ",
          fillColor: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _password = value,
      controller: _passwordTextController,
      obscureText: true,
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty || value.length <= 6) {
          return "ກະລຸນາປ້ອນລະຫັດຜ່ານ ແລະ ຕ້ອງຫຼາຍກວ່າ 6 ອັກສອນ";
        }
      },
    );
  }

  Widget confirmPassword() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "ຢືນຢັນລະຫັດຜ່ານ",
          hintText: "ກະລຸນາປ້ອນລະຫັດຜ່ານ",
          fillColor: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _password = value,
      obscureText: true,
      autovalidate: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return "ກະລຸນາປ້ອນລະຫັດຜ່ານໃຫ້ກົງກັນ";
        }
        if (value.isEmpty) {
          return "ກະລຸນາຢືຶນຢັນລະຫັດຜ່ານ";
        }
      },
    );
  }
}
