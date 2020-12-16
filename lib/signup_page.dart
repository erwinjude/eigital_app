import 'package:eigital_app/appbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String confirmPassword;
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text(
              errorMsg,
              style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                confirmPassword = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 100, right: 100, bottom: 10),
            child: FlatButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                try {
                  if (password == confirmPassword) {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      errorMsg = '';
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return AppBarPage(
                          userEmail: email,
                        );
                      }));
                    }
                  } else {
                    setState(() {
                      errorMsg = 'Password does not match.';
                    });
                  }
                } catch (e) {
                  setState(() {
                    if (password.length < 6) {
                      errorMsg = 'Password must be atleast 6 characters.';
                    } else {
                      errorMsg = 'Invalid email';
                    }
                  });
                }
              },
              child: Text('SIGN UP'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.green,
            ),
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.only(left: 100, right: 100),
            child: FlatButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('CANCEL'),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
