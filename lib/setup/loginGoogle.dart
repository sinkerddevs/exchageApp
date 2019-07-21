import 'package:exchange/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String _emailValue;
  String _passwordValue;
  bool _acceptTerm = false;
  bool s = false;
  GoogleSignIn googleAuth = new GoogleSignIn();

  final _formkey = GlobalKey<FormState>();
  Future<void> signIn_firebase() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailValue, password: _passwordValue);
        s = true;
        Navigator.of(context).pushNamed('/Homepage');
      } catch (e) {
        s = true;
        print(e.message);
        _showWarningDialog(context);
      }
    } else if (!_formkey.currentState.validate()) {
      _showWarningDialog(context);
      Navigator.of(context).pop();
    } else {
      _showWarningFlaised(context);
      Navigator.of(context).pop();
    }
  }

  _showWarningDialogLoad(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'ກຳລັງໂຫຼດ...',
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
          );
        });
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
            content: Text('ອີເມວ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "ເຂົ້າສຸ່ລະບົບ",
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

  _showWarningFlaised(BuildContext context) {
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
            content: Text('ອີເມວ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "ເຂົ້າສຸ່ລະບົບ",
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
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;
    return new Scaffold(
        body: Container(
            color: Colors.white70,
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(12),
                  child: Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                          child: Container(
                        width: targetWidth,
                        child: Column(
                          children: <Widget>[
                            logo(),
                            buildTextFieldEmail2("ອີເມວ"),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFieldPassword2("ລະຫັດຜ່ານ"),
                            SwitchListTile(
                              value: _acceptTerm,
                              onChanged: (bool value) {
                                setState(() {
                                  _acceptTerm = value;
                                });
                              },
                              title: Text(
                                "ຍອມຮັບເງື່ອນໄຂ",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            buildButtonLoginIn(context),
                            buildForgetPassword(),
                            or(),
                            // buildButtonGoogle(context),
                            // buildButtonFacebook(context),
                            
                            resetPassword(context),
                          ],
                        ),
                      )

                          // mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          ))),
            )));
  }

  Container logo() {
    return Container(
      padding:
          EdgeInsets.only(bottom: 15.0, top: 10.0, left: 70.0, right: 70.0),
      child: Image.asset('assets/ltc.png'),
    );
  }

  Container buildForgetPassword() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("ທ່ານເປັນສະມາຊິກແລ້ວ ຫຼື ບໍ ?",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14, color: Colors.black54)),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: Text(
                "ລົງທະບຽນ",
                style: TextStyle(color: Theme.of(context).primaryColor),
              )),
        ],
      ),
    );
  }

  Widget buildTextFieldEmail2(String hintText) {
    return new TextFormField(
      onSaved: (String value) => _emailValue = value,
      decoration: new InputDecoration(
        labelText: "ອີເມວ",
        fillColor: Colors.white,
        filled: true,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
          borderSide: new BorderSide(),
        ),
        prefixIcon: Icon(Icons.email),
        //fillColor: Colors.green
      ),
      keyboardType: TextInputType.emailAddress,
      style: new TextStyle(
        fontFamily: "phetsarath OT",
      ),
      validator: (String value) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (value.isEmpty || !regex.hasMatch(value)) {
          return "ກະລຸນາປ້ອນອີເມວໃຫ້ຖືກຕ້ອງ";
        }
      },
    );
  }

  Container or() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(" ຫຼື ",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 15, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget buildTextFieldPassword2(String hintText) {
    return new TextFormField(
      onSaved: (String value) => _passwordValue = value,
      decoration: new InputDecoration(
        labelText: "ລະຫັດຜ່ານ",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
          borderSide: new BorderSide(),
        ),
        prefixIcon: Icon(Icons.lock),
        //fillColor: Colors.green
      ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return "ກະລຸນາປ້ອນລະຫັດຜ່ານຂອງທ່ານ";
        }
      },
    );
  }

  Widget buildButtonLoginIn(BuildContext context) {
    var inkWell = InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 45),
        child: Text("ເຂົ້າສູ່ລະບົບ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.red),
        margin: EdgeInsets.only(top: 1),
        padding: EdgeInsets.all(12),
      ),
      onTap: () => signIn_firebase(),
    );
    return inkWell;
  }

  Widget buildButtonFacebook(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 40),
            child: Text("ເຂົ້າສູ່ລະບົບດ້ວຍ Facebook ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(10)),
        onTap: () => {}); //loginWithFacebook(context));
  }

  Widget resetPassword(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 40),
            child: Text("ຣີເຊັດລະຫັດຜ່ານ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.red),
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(10)),
        onTap: () => Navigator.of(context).pushNamed('/resetpassword'));
  }

  Widget buildButtonGoogle(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 40),
            child: Text("ເຂົ້າສູ່ລະບົບດ້ວຍ Google ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(10)),
        onTap: () => loginWithGoogle(context));
  }

  // void loginGoogle() {
  //   googleAuth.signIn().then((result) {
  //     result.authentication.then((googleKey) {
  //       FirebaseAuth.instance.signInWithGoogle(
  //         idToken: googleKey.accessToken,
  //         accessToken: googleKey.accessToken
  //       ).then((signedInuser){

  //       }).
  //     }).catchError((e) {
  //       print(e.message);
  //     }).catchError((e) {
  //       print(e.message);
  //     });
  //   });
  // }

  Future loginWithGoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount user = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await user.authentication;

    await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: userAuth.idToken, accessToken: userAuth.accessToken));
    checkAuth(context); // after success route to home.
  }

  Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
