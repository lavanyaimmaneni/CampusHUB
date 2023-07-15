import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Navbar extends StatefulWidget {
  const Navbar ({super.key});

  @override
  State<Navbar > createState() => _NavbarState();
}

class _NavbarState extends State<Navbar > {
  @override

  String profilepic = 'https://www.dgvaishnavcollege.edu.in/dgvaishnav-c/uploads/2021/01/dummy-profile-pic.jpg';
  void get_profile_pic() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profilepic = prefs.getString('profilepic') ?? "";
    });
  }

  void initState(){
    get_profile_pic();
  }

  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 197, 131, 207),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                // color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(profilepic),)
              ),
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.input),
          //   title: Text('Welcome'),
          //   onTap: () => {},
          // ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.of(context).pop(),
             Navigator.pushNamed(context, '/home')
             },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Post A Question'),
            onTap: () => {
              Navigator.of(context).pop(),
             Navigator.pushNamed(context, '/newquestion')
             },
          ),
          ListTile(
            leading: Icon(Icons.question_mark_rounded),
            title: Text('My Questions'),
            onTap: () => {
                            Navigator.of(context).pop(),
                            Navigator.pushNamed(context, '/myposts')
                          },
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle_rounded),
            title: Text('Profile'),
            onTap: () => {
                            Navigator.of(context).pop(),
                            Navigator.pushNamed(context, '/profile')
                          },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.popUntil(context, (route) => false),
              Navigator.pushNamed(context, '/')
            },
          ),
        ],
      ),
    );
  }
}