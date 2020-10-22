//import 'dart:html';
//import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:my_first_app/home.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  var fs = FirebaseFirestore.instance;
  File imagefilepath;
  var imgurl;
  var furl;
  //File imagename;

  clickphoto() async {
    var picker = ImagePicker();
    var image = await picker.getImage(
      source: ImageSource.gallery,
      //  maxWidth: 200,
      //  maxHeight: 200,
    );

    setState(() {
      imagefilepath = File(image.path);
      //imagename = File(basename(image.path));
    });
    //print(imagename);
    print(imagefilepath);
    print('photo clicked');

    var fbstorage = FirebaseStorage.instance
        .ref()
        .child("ProfileImage")
        .child("${imagefilepath}");
    print(fbstorage);

    await fbstorage.putFile(imagefilepath).onComplete;

    imgurl = await fbstorage.getDownloadURL();
    print(imgurl);

    setState(() {
      furl = imgurl;
    });
  }

  String username;

  String email;
  String password;
  String confirmPassword;

  @override
  initState() {
    //firstNameInputController = new TextEditingController();

    //emailInputController = new TextEditingController();
    //pwdInputController = new TextEditingController();
    //confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  String nameValidator(String value) {
    if (value.length < 3) {
      return "Please enter a valid last name.";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            'Registration',
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
                child: SingleChildScrollView(
                    child: Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () => clickphoto(),
                        child: CircleAvatar(
                          backgroundImage: furl != null
                              ? NetworkImage(furl)
                              : AssetImage('images/camera.jpg'),
                          maxRadius: 50,
                          backgroundColor: Colors.green[600],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          username = value;
                        },
                        validator: nameValidator,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 20),
                          filled: true,
                          hintText: "Enter Username",
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: emailValidator,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 20),
                          filled: true,
                          hintText: "Enter Email",
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: pwdValidator,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 20),
                          filled: true,
                          hintText: "Enter Password",
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        validator: pwdValidator,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 20),
                          filled: true,
                          hintText: "Re Enter Password",
                          hoverColor: Colors.white,
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
                            'Submit',
                            style: new TextStyle(
                                fontSize: 25.0, color: Colors.white),
                          ),
                          onPressed: () {
                            if (_registerFormKey.currentState.validate()) {
                              if (password == confirmPassword) {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: email, password: password)
                                    .then((currentUser) => Firestore.instance
                                        .collection("DataStore")
                                        .document(email)
                                        .setData({
                                          "username": username,
                                          "profilepic": furl,
                                          "email": email,
                                        })
                                        .then((result) => {
                                              Navigator.pushNamed(
                                                  context, "login")
                                            })
                                        .catchError((err) => print(err)))
                                    .catchError((err) => print(err));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content:
                                            Text("The passwords do not match"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("If you already have an account"),
                      FlatButton(
                        child: Text("Login here!"),
                        onPressed: () {
                          Navigator.pushNamed(context, "login");
                        },
                      )
                    ],
                  ),
                )))));
  }
}
