import 'package:flutter/material.dart';
import 'package:quora_clone/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Utils.dart';
class Comment extends StatefulWidget {
  // const Comments({super.key});
  Comments_class c;
  Comment({required this.c});
  @override
  State<Comment> createState() => _CommentState(c: c);
}

Future<List<Comment>> get_comments(String postid)async{

    final client = http.Client();
    List<Comment> comments_list = [];
    try {
        var response = await client.post(
            Uri.https('college-hub-service.onrender.com', 'comment/getcomments'),
            body: {'postid' : postid}
        );
        Map res = jsonDecode(response.body);
        print(res);
        var resp = res['data'];
        // print(resp[0]['_id']);
        // print(resp.length);

        // Map data = res['data'][0];
        // print(data['username']);
        List<Comments_class> lists = [];
        for(int i = 0 ; i < resp.length ; i++)
        {
          Comments_class newcomment = new Comments_class(commentdesc: resp[i]['commentdesc'], commentid: resp[i]['commentdesc'], commentowner: resp[i]['commentowner'], downvotes: resp[i]['downvotes'], ownerprofile: resp[i]['ownerprofile'], posteddate: resp[i]['posteddate'], postid: resp[i]['postid'], upvotes: resp[i]['upvotes']);
          lists.add(newcomment);
        }
        if(res['success'])
        {
          comments_list = lists.map((com) => Comment(c: com)).toList();
          // print(res['data'][0]);
          // Map data = jsonDecode(res['data'][0].toString());
          // User newuser =  User(email: data['email'], name: data['name'], profilepic: data['profilepic'], role: data['role'], upvotes: data['upvotes'], username: data['username']);
          // // SetUser(newuser);
          // print(newuser.profilepic);
          // Navigator.popAndPushNamed(context, '/home');
        }
        else
        {
          
        }
      }catch(e){
        print(e);
        
      } finally {
        client.close();
    }
    return comments_list;
}

class _CommentState extends State<Comment> {
  @override
  Comments_class c;
  int noofupvotes = 0;
  int noofdownvotes = 0;
  _CommentState({required this.c});
  void initState(){
    // get_comments(postid);
  noofupvotes = c.upvotes;
  noofdownvotes = c.downvotes;
  }

  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.2, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.01),
          decoration: const BoxDecoration(
            // color : Color.fromARGB(255, 211, 212, 212),
            // borderRadius: BorderRadius.circular(36.0)
          ),
          width: MediaQuery.of(context).size.width*0.68,
          alignment: Alignment.topLeft,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(c.ownerprofile),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0 , right : 50.0),
                    child : Text(
                            c.commentowner,
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          )
                  ),
                  Text(
                    c.posteddate.substring(0,10),
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.006,
              ),
              Text(
                c.commentdesc,
                style: TextStyle(
                  fontFamily: "Opensans",
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.005,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        noofupvotes += 1;
                      });
                    }, 
                    icon : const Icon(
                        Icons.arrow_circle_up , 
                        color: Colors.green,
                        size: 33,
                        fill: 0.5,
                        // semanticLabel: "24",
                      ),
                  ),
                  Text(
                    noofupvotes.toString(),
                    style: const TextStyle(
                            // fontFamily: "Opensans",
                            // fontWeight: FontWeight.bold,
                            fontSize: 15.0
                          ),
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        noofdownvotes += 1;
                      });
                    }, 
                    icon : const Icon(
                        Icons.arrow_circle_down_outlined , 
                        color: Colors.red,
                        size: 33,
                        fill: 0.5,
                        // semanticLabel: "24",
                      ),
                  ),
                  Text(
                    noofdownvotes.toString(),
                    style: const TextStyle(
                            // fontFamily: "Opensans",
                            // fontWeight: FontWeight.bold,
                            fontSize: 15.0
                          ),
                  )
                ],
              )
            ],
          ),
    );
  }
}

class Comments extends StatelessWidget {
  // const Comments ({super.key});

  String postid;
  Comments({required this.postid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                  child: Column(
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
          future: get_comments(postid),
    );
  }
}