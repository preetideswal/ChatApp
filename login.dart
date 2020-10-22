import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var authc = FirebaseAuth.instance;

  String email;
  String password;
  //bool sspin = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: new TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,

          ///child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: MaterialButton(
                  minWidth: 200,
                  height: 60,
                  child: Text(
                    'Login',
                    style: new TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  onPressed: () async {
                    try {
                      var userSignin = await authc.signInWithEmailAndPassword(
                          email: email, password: password);
                      print(userSignin);

                      if (userSignin != null) {
                        Navigator.pushNamed(context, "chat");
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "email or password invalid",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Don't have an account yet?"),
              FlatButton(
                child: Text("Register here!"),
                onPressed: () {
                  Navigator.pushNamed(context, "reg");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
