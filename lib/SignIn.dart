import 'package:firebase_app/home.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}
class SignInState extends State<SignIn> {
  final database=FirebaseDatabase.instance.reference().child("users");
  String email="",password="";
  TextEditingController _email,_pass;
  final GlobalKey<FormState> formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _email,
              validator: (input) {
                if(input.isEmpty) return "Enter the Email ID";
              },
              decoration: InputDecoration(
                labelText: "Email",
              ),
              onSaved: (input)
              {
                email=input;
              },
            ),
            TextFormField(
              controller: _pass,
              validator: (input) {
                if(input.length<6) return "Password needs to be greater than 6 characters";
              },
              decoration: InputDecoration(
                labelText: "Password",
              ),
              onSaved: (input)
              {
                password=input;
              },
              obscureText: true,
            ),
            RaisedButton(
              child: Text("Sign In"),
              onPressed: () {
                signin();
              },
            )

          ],
        ),
      ),
    );

  }
Future<void> signin() async
  {

    final formState=formKey.currentState;
    if(formState.validate())
    {
      formState.save();
      try{
      FirebaseUser user= (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      )).user;

      update(user.uid);
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>new Home(user)));
      }
      catch(e)
      {
        print(e.message);
        showAlert(context,e.message);
      }
    }
  }
Future<void> update(String x) async {
      database.child(x).update({
      'presence': 'true'
      });
}
 void showAlert(BuildContext context, String x)
 {
   var alert=AlertDialog(
     title: Text("Cannot Sign In"),
     content: Text(x)
   );
   showDialog(context: context,
   builder: (BuildContext context)
   {
     return alert;
   }
   );
 } 
}