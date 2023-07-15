import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'dart:convert';
import 'main.dart';
import 'User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  String errormsg = "";
  bool is_error = false;
  final _form = GlobalKey<FormState>();
  static String username = "";
  static String Password = "";
  
  Future<void> AutoLogin() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('email') ?? "";
    print(username);
    print("AutoLogin called");
    if(username != "")
    {
      Navigator.popAndPushNamed(context, '/home');
    }
  }

  // void initState (){
  //   AutoLogin();
  //   print("AutoLogin executed");
  // }

  Future<void> validate() async {

    final client = http.Client();
    try {
          SharedPreferences.setMockInitialValues({});
          SharedPreferences prefs = await SharedPreferences.getInstance();
        var response = await client.post(
            Uri.https('college-hub-service.onrender.com', 'auth/signin'),
            body: {'username': username, 'password': Password}
        );
        Map res = jsonDecode(response.body);
        Map data = res['data'][0];
        print(data['username']);
        if(res['success'])
        {
          // print(res['data'][0]);
          // Map data = jsonDecode(res['data'][0].toString());
          

          prefs.setString('email', data['email']);
          print("mail set");
          String username = prefs.getString('email') ?? "";
          print("The mail is ---- " + username);
          // prefs.setString('name', data['name']);
          prefs.setString('username', data['username']);
          prefs.setString('profilepic', data['profilepic']);
          prefs.setString('role', data['role']);
          prefs.setInt('upvotes', data['upvotes']);
          print(prefs.getInt('upvotes'));
          // User newuser =  User(email: data['email'], name: data['name'], profilepic: data['profilepic'], role: data['role'], upvotes: data['upvotes'], username: data['username']);
          // // SetUser(newuser);
          // print(newuser.profilepic);
          Navigator.popAndPushNamed(context, '/home');
        }
        else
        {
          setState(() {
            is_error = true;
            errormsg = res['msg'];
          });
        }
      }catch(e){
        print(e);
        setState(() {
          is_error = true;
          errormsg = "Error try again";
        });
      } finally {
        client.close();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 197, 131, 207),
      ),
      body:SingleChildScrollView(child: Form(
        key: _form,
        child: Container(
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.15, 0, MediaQuery.of(context).size.width*0.15, 0),
            child :Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Visibility(
                visible: is_error,
                child: Center(
                  child: Text(
                    errormsg,
                    style: TextStyle(
                      color: Colors.red
                    ),
                    ),
                  )
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              TextFormField(
                onChanged: (val){
                  username = val;
                  setState(() {   
                      // errormsg = "Incorrect Details";
                      is_error = false;
                    });
                },
                decoration: InputDecoration(
                  labelText: "Enter your username",
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              TextFormField(
                onChanged: (val){
                  Password = val;
                  if(is_error)
                  {
                    setState(() {   
                      // errormsg = "Incorrect Details";
                      is_error = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter your Password",
                ),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => {Navigator.pushNamed(context, '/signup')},
                    child : Text(
                      "signup here",
                      style: TextStyle(
                        color: Colors.blue
                      ),
                      ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              ElevatedButton(
                onPressed: (){
                  validate();
                  // if(username == "lavanya" && Password == "123456")
                  // {
                  //   Navigator.popAndPushNamed(context, '/home');
                  // }
                  // else
                  // {
                  //   setState(() {   
                  //     errormsg = "Incorrect Details";
                  //     is_error = true;
                  //   });
                  // }
                },
                child: Text("Signin"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              )
            ],
          ),
        ),
      ),
      )
    );
  }
}