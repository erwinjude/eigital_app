import 'dart:io';
import 'package:eigital_app/appbar.dart';
import 'package:eigital_app/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EigitalApp());
}

class EigitalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/appbar': (context) => AppBarPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String email;
  String password;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          exit(0);
        },
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 25,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
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
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.security,
                  color: Colors.grey,
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
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
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    errorMsg = '';
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return AppBarPage(
                        userEmail: email,
                      );
                    }));
                  }
                } catch (e) {
                  setState(() {
                    errorMsg = 'The user does not exist.';
                  });
                }
              },
              child: Text('LOGIN'),
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
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: Text('SIGN UP'),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
