import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Data Storage App',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green[900]),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: MaterialButton(
                  minWidth: 200,
                  height: 60,
                  child: Text('Registration',
                      style: new TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white,
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, "reg");
                  },
                ),
              ),
              SizedBox(
                height: 40,
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
                    style: new TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
