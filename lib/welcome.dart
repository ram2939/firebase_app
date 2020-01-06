import 'package:flutter/material.dart';
import 'package:firebase_app/Signup.dart';
import 'package:firebase_app/SignIn.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Firebase App"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.all(5.0),
              color: Colors.black,
              child: Text(
                "Sign In",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),
            RaisedButton(
              padding: EdgeInsets.all(5.0),
              color: Colors.black,
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
            )
          ],
        ),
      ),
    );
  }
}
