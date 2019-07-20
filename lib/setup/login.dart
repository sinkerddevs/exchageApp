import 'package:exchange/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding:
            EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0, bottom: 10.0),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,.

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
                  try {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    Navigator.of(context).pushReplacementNamed('/Homepage');
                  } catch (e) {
                    print(e);
                  }
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
                  Text("ທ່ານມີໃບຊີແລ້ວ ຫຼື ບໍ?"),
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/loginGoogle');
                      },
                      child: Text(
                        "ລົງທະບຽນ",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                  buildButtonGoogle(context)
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

  Widget buildButtonGoogle(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Login with Google ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.blue[600])),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)),
        onTap: () => loginWithGoogle(context));
  }

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
