import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateNewUser extends StatefulWidget {
  CreateNewUser({Key key}) : super(key: key);

  _CreateNewUserState createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  final _formkey = GlobalKey<FormState>();
  String _emailValue = '';
  String _passwordValue = '';
  String _userName = '';
  num _age = 0;
  // void submit_form(String email, String password) {
  //   if (_formkey.currentState.validate()) {
  //     _formkey.currentState.save();
  //     print(email);
  //     print(password);
  //     final Map<String, dynamic> userData = {
  //       'email': email,
  //       'password': password,
  //     };
  //     http.post('https://exchange-330dd.firebaseio.com/newusers.json',
  //         body: json.encode(userData));
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('ເພີ່ມຜູ່ໃຊ້ພາຍໃນລະບົບ'),
        ),
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
                        buildNameField(),
                        SizedBox(
                          height: 10.0,
                        ),
                        buildAgeField(),
                        SizedBox(
                          height: 10.0,
                        ),
                        buildEmailField(),
                        SizedBox(
                          height: 5.0,
                        ),
                        buildpassField(),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton.icon(
                          label: Text(
                            "ເພີ່ມຜູ່ໃຊ້",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          colorBrightness: Brightness.dark,
                          color: Colors.deepOrange,
                          icon: Icon(Icons.add),
                          onPressed: () => _submit(
                              _userName, _age, _emailValue, _passwordValue),
                        )
                      ],
                    )))));
  }

  Widget buildEmailField() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "ອີເມວ",
          hintText: "ກະລຸນາປ້ອນອີເມວຂອງທ່ານ",
          fillColor: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _emailValue = value,
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty) {
          return "ກະລຸນາປ້ອນອີເມວຂອງທ່ານ";
        }
      },
    );
  }

  Widget buildNameField() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "ຊື່ ແລະ ນາມສະກຸນ",
          hintText: "ກະລຸນາປ້ອນຊື່ ແລະ ນາມສະກຸນ",
          filled: true,
          fillColor: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _userName = value,
    );
  }

  Widget buildAgeField() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "ອາຍຸ",
          hintText: "ກະລຸນາປ້ອນອາຍຸຂອງທ່ານ",
          fillColor: Colors.white),
      keyboardType: TextInputType.number,
      onSaved: (String value) => _age = num.parse(value),
    );
  }

  Widget buildpassField() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "ລະຫັດຜ່ານ",
          hintText: "ກະລຸນາປ້ອນລະຫັດຜ່ານ",
          fillColor: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _passwordValue = value,
      obscureText: true,
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty || value.length <= 6) {
          return "ກະລຸນາປ້ອນລະຫັດຜ່ານ ແລະ ຕ້ອງຫຼາຍກວ່າ 6 ອັກສອນ";
        }
      },
    );
  }

  void _submit(String name, num age, String email, String password) {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      final Map<String, dynamic> userData = {
        'name': _userName,
        'age': _age,
        'email': _emailValue,
        'password': _passwordValue,
      };
      http.post('https://exchange-330dd.firebaseio.com/newusers.json',
          body: json.encode(userData));
      Navigator.pop(context);
    }
  }
}
