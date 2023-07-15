import 'package:flutter/material.dart';
import 'Doubt.dart';
import 'Utils.dart';
import 'navbar.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'dart:convert';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  bool is_error = false;
  String errormsg = "";

  
  List<Doubt> doubts_recieved = [];

  Future<List<Doubt>> getDoubts()async{
    final client = http.Client();
    try {
        var response = await client.get(
            Uri.https('college-hub-service.onrender.com', 'post/allposts'),
        );
        Map res = jsonDecode(response.body);
        // print(res);
        var posts = res['posts'];
        print(posts[0]['_id']);
        List<Post> posts_recieved = [];
        for(int i = 0 ; i < posts.length ; i++)
        {
            Post newpost = new Post(postdesc: posts[i]['postdesc'], posteddate: posts[i]['posteddate'], postid: posts[i]['_id'], postowner: posts[i]['postowner'], mode: posts[i]['mode'], ownerprofile: posts[i]['ownerprofile']);
            posts_recieved.add(newpost);
        }
        // print(data['username']);
        if(res['success'])
        {
          // User newuser =  User(email: data['email'], name: data['name'], profilepic: data['profilepic'], role: data['role'], upvotes: data['upvotes'], username: data['username']);
          // // SetUser(newuser);
          // print(newuser.profilepic);
          doubts_recieved = posts_recieved.map((post) => Doubt(p:post)).toList();
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
    return doubts_recieved;
  }

  @override

  // void initState(){
  //   print("state initiated");
  //   getDoubts();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Navbar(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 197, 131, 207),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.person_pin,
                  size: 36,
                  // color: Colors.red, // Change Custom Drawer Icon Color
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: FutureBuilder(
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
 
                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                // final data = snapshot.data as String;
                return Center(
                  child: ListView(
                    children: snapshot.data!,
                  )
                );
              }
            }
 
            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
 
          // Future that needs to be resolved
          // inorder to display something on the Canvas
          future: getDoubts(),
        ),
            
      );
  }
}