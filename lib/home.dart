import 'dart:async';
import 'package:firebase_app/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  Home(this.user);
  @override
  State<StatefulWidget> createState() {
    return HomeState(user);
  }
}

class HomeState extends State<Home> {
  final FirebaseUser user;
  List<String> list = [];
  HomeState(this.user);
  final database = FirebaseDatabase.instance.reference().child("users");
  @override
  void initState() {
    super.initState();
    getUsers().then(updateList);
    database.onChildChanged.listen(onchildchanged);
  }

  @override
  void dispose() {
    super.dispose();
    database.onChildChanged.listen(onchildchanged).cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome " + user.email,
          overflow: TextOverflow.fade,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: "Signout",
            onPressed: () {
              database.child(user.uid).update({'presence': 'false'});
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomePage()));
              showAlert(context);
            },
          )
        ],
      ),
      body: _myListView(context),
    );
  }

  Widget _myListView(BuildContext context) {
    // backing data
    list.remove(user.email);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Card(
          borderOnForeground: true,
         child : 
         Padding(
           padding: EdgeInsets.all(8.0),
           child: Center(
           child: Text(list[index],
          style: TextStyle(
           fontSize: 20,
           fontStyle: FontStyle.italic,
           color: Colors.redAccent
         ),
         ),
         ),
         ),
         elevation: 10.0,
        );
      },
    );
  }

  onchildchanged(Event event) {
    setState(() {
      if ((event.snapshot.value['presence']) == "true") {
        list.add(event.snapshot.value['email']);
      } else
        list.remove(event.snapshot.value['email']);
    });
  }

  void showAlert(BuildContext context) {
    var alert = AlertDialog(
      title: Text("You have been signed out"),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Future<List<String>> getUsers() async
  {
    Completer<List<String>> l = new Completer<List<String>>();
    List<String> x = [];
    FirebaseDatabase.instance
        .reference()
        .child("users")
        .once()
        .then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        if ((value[key]['presence']) == "true")
          x.add(value[key]['email'].toString());
      }
      l.complete(x);
    });
    return l.future;
}
  updateList(List<String> value) {
    setState(() {
      list = value;
    });
  }
}
