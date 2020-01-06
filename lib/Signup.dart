import 'package:firebase_app/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}
class SignUpState extends State<SignUp> {
  final database=FirebaseDatabase.instance.reference().child("users");
  String email="",password="";
  final GlobalKey<FormState> formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
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
              child: Text("SignUp"),
              onPressed: () {
                signup();
              },
            )
          ],
        ),
      ),
    );
  }
  Future<void> signup() async
  {

    final formState=formKey.currentState;
    if(formState.validate())
    {
      formState.save();
     try{
      FirebaseUser user= (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      )).user;
      database.child(user.uid).set(
        {
        'email': user.email,
        'presence':false,  
        }
      );
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
     }
     catch(e)
     {
       showAlert(context, e.message);
     }
    }
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