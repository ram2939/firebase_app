import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/Signup.dart';
import 'package:firebase_app/SignIn.dart';
class WelcomePage extends StatelessWidget{
@override
Widget build(BuildContext context)
{
  return Scaffold(
    appBar: AppBar(
      title: Text("Welcome"),
    ),
    body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RaisedButton(
            color: Colors.black,
            child: Text("Sign In",
            style: TextStyle(
              color: Colors.white
            ),
            ),
            onPressed: () 
            {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
             },
          ),
          RaisedButton(
            color: Colors.black,
            child: Text("Sign Up",
            style: TextStyle(
              color: Colors.white
            ),
            ),
            onPressed: () { 
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
            },
          )
        ],
      ),
    ),
  );
}
}