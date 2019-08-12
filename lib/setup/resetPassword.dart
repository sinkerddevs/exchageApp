import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key key}) : super(key: key);

  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formkey = GlobalKey<FormState>();
  String _email, _password;
  final TextEditingController _emails = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void reset() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        _showWarningDialogTure(context);
      } catch (e) {
        print(e.message);
      }
    } else {
      _showWarningDialogflase(context);
    }
  }

  _showWarningDialogTure(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'ການດຳເນີນການສຳເລັດແລ້ວ',
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
            content: Text('ກະລຸນາກວດສອບລະຫັດໃນອີເມວ'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "ເຂົ້າສູ່ລະບົບ",
                  style: TextStyle(color: Colors.blue.withOpacity(1.0)),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/loginGoogle');
                },
              ),
            ],
          );
        });
  }

  _showWarningDialogflase(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'ລົ້ມເຫຼວ',
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
            content: Text('ກະລຸນາກວດສອບທີ່ຢູ່ອີເມວ!!'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "ດຳເນີນການຕໍ່",
                  style: TextStyle(color: Colors.blue.withOpacity(1.0)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
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
                                  "ຣີເຊັດລະຫັດຜ່ານ",
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
                          height: 25.0,
                        ),
                        RaisedButton.icon(
                          label: Text(
                            "ຂໍລະຫັດຜ່ານໃໝ່",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          colorBrightness: Brightness.dark,
                          color: Colors.red[500],
                          icon: Icon(Icons.restore),
                          onPressed: () => reset(),
                        )
                      ],
                    )))));
  }

  Container logo() {
    return Container(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 98.0, left: 98.0),
      child: Image.asset('assets/dd.png'),
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
      controller: _emails,
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
}
