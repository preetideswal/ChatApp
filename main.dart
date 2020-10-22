import 'package:animationApp/ui/chat.dart';
import 'package:animationApp/ui/current.dart';
import 'package:animationApp/ui/home.dart';
import 'package:animationApp/ui/reg.dart';
import 'package:animationApp/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "screen",
      routes: {
        //"WatchApi": (context) => WatchApi(),
        //"CarApi": (context) => CarApi(),
        //"BikeApi": (context) => BikeApi(),
        //"PhoneApi": (context) => PhoneApi(),
        //"GunApi": (context) => GunApi(),
        //"api": (context) => DataApi(),
        "home": (context) => MyHome(),
        "reg": (context) => RegisterPage(),
        "login": (context) => MyLogin(),
        "screen": (context) => MyApp(),
        "chat": (context) => ChatPage(),
        "current": (context) => Current(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 8,
      navigateAfterSeconds: new Current(),
      title: new Text(
        'Welcome!',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: Colors.black,
            decorationColor: Colors.black),
      ),
      image: new Image.asset('images/chat.jpg'),
      //backgroundGradient: new LinearGradient(colors: [Colors.cyan, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      //onClick: () => print("Your storage"),
      loaderColor: Colors.green,
    );
  }
}
