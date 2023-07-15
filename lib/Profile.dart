import 'package:flutter/material.dart';
import 'package:quora_clone/navbar.dart';
import 'main.dart';
import 'User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String email = "";
  String username = "";
  int upvotes = 0;
  String role = "";
  String profilepic = "https://pinnacle.works/wp-content/uploads/2022/06/dummy-image.jpg";

  void Getuser()async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {  
      email = prefs.getString('email') ?? "";
      username = prefs.getString('username') ?? "";
      role = prefs.getString('role') ?? "";
      profilepic = prefs.getString('profilepic') ?? "";
      upvotes = prefs.getInt('upvotes') ?? 0;
      print(profilepic);
      print(role);
    });
  }

  @override

  void initState(){
    print("state loaded");
    Getuser();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 197, 131, 207),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.person_pin,
                size : 36,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Navbar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(profilepic),
              radius: 50.0,
            ),
          ),
          Divider(
            height: 50.0,
          ),
          Text(
            'Username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            username,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 21.0,
              fontWeight: FontWeight.w700
            ),
          ),
          // SizedBox(
          //   height: 30.0,
          // ),
          // Text(
          //   'Name',
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // SizedBox(
          //   height: 5.0,
          // ),
          
          // Text(
          //   user.name,
          //   style: TextStyle(
          //     fontFamily: 'Ubuntu',
          //     fontSize: 21.0,
          //     fontWeight: FontWeight.w700
          //   ),
          // ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.email_outlined ,),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                email,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 18.0,
                ),
              ),
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Role',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            role,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 24.0,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          // Text(
          //   'Comments Posted',
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // SizedBox(
          //   height: 5.0,
          // ),
          // Text(
          //   "2",
          //   style: TextStyle(
          //     fontFamily: 'Ubuntu',
          //     fontSize: 24.0,
          //     fontWeight: FontWeight.w700
          //   ),
          // ),
          // SizedBox(
          //   height: 30.0,
          // ),
          Text(
            'Total Upvotes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            upvotes.toString(),
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 24.0,
              fontWeight: FontWeight.w700
            ),
          ),
        ],
       ),
      )
    );
  }
}