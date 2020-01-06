import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  final FirebaseUser user;
  Home(this.user);
  @override
  State<StatefulWidget> createState(){
    return HomeState(user);
  }
}
  class HomeState extends State<Home>{
   final FirebaseUser user;
   List<String> list = [];
  HomeState(this.user);
  final database=FirebaseDatabase.instance.reference().child("users");
  @override
  void initState() 
  {
    super.initState();
    FirebaseDatabase.instance.reference().child("users").once().then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {

        if((value[key]['presence'])=="true")
        list.add(value[key]['email'].toString());
      }
});
    database.onChildChanged.listen(onchildchanged);
  }
  @override
  Widget build(BuildContext context)
  {
    
      return Scaffold(
        appBar: AppBar(
          title: Text("Welcome "+user.email,
          overflow: TextOverflow.fade,),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () 
              {
                database.child(user.uid).update(
                  {
                    'presence':'false'
                  }
                );
                Navigator.pop(context);
              },
            )
          ],
            
          ),
        body: _myListView(context),
      );
  }
  Widget _myListView(BuildContext context) {
      // backing data
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(list[index]),
          );
        },
      );

    }
    onchildchanged(Event event)
    {
      List<String> l;
      setState(() {
        if((event.snapshot.value['presence'])=="true")
        {  list.add(event.snapshot.value['email']);
        }
        else list.remove(event.snapshot.value['email']);
      });
  }
}