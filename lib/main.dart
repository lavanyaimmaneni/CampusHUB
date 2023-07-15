import 'package:flutter/material.dart';
import 'package:quora_clone/AppBar.dart';
import 'package:quora_clone/Myposts.dart';
import 'package:quora_clone/NewQuestion.dart';
import 'package:quora_clone/Profile.dart';
import 'package:quora_clone/Signin.dart';
import 'package:quora_clone/Signup.dart';
import 'navbar.dart';
import 'Utils.dart';
import 'Doubt.dart';
import 'DoubtExpanded.dart';
import 'User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home.dart';
void main() {
  runApp(const MyApp());
  
  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
                "/home" : (context) => Homepage() ,
                "/newquestion" : (context) => NewQuestion(),
                "/profile" : (context) => Profile(),
                "/" : (context) => Signin(),
                "/signup" : (context) => Signup(),
                "/myposts" : (context) => Myposts()
              },
      initialRoute: "/",
      // home: Scaffold(
      //   drawer: Navbar(),
      //   appBar: AppBar(),
      // ),
    );
  }
}

