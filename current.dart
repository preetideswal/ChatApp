import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Current extends StatefulWidget {
  @override
  _CurrentState createState() => _CurrentState();
}

class _CurrentState extends State<Current> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  initState() {
    // body();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Material(
                //color: Colors.green[600],
                borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: MaterialButton(
                  minWidth: 200,
                  height: 60,
                  child: Text(
                    'Next...',
                    style:
                        new TextStyle(fontSize: 25.0, color: Colors.green[900]),
                  ),
                  onPressed: () {
                    try {
                      var currentUser = _auth.currentUser;
                      if (currentUser == null) {
                        Navigator.pushNamed(context, "home");
                      } else {
                        var data = Firestore.instance
                            .collection("DataStore")
                            .document(currentUser.email)
                            .get()
                            .then(
                              (DocumentSnapshot result) =>
                                  Navigator.pushNamed(context, "chat"),
                            );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ))));
  }
}
