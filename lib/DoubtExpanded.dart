import 'package:flutter/material.dart';
import 'package:quora_clone/Utils.dart';
// import 'package:quora_clone/Question.dart';
import 'Comments.dart';
import 'package:quora_clone/navbar.dart';
import 'Utils.dart';
import 'Apicalls.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DoubtExpanded extends StatefulWidget {

  Post p;
  DoubtExpanded({required this.p});
  

  // const DoubtExpanded({super.key});

  @override
  State<DoubtExpanded> createState() => _DoubtExpandedState(p: p);
}

class _DoubtExpandedState extends State<DoubtExpanded> {

  Post p;
  bool has_access = false;
  _DoubtExpandedState({required this.p});

  @override

  Future<void> get_access(String accessed_role)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_role = prefs.getString('role') ?? "";
    if(accessed_role == 'teacher' || user_role == 'student')
    {
      setState(() {
        has_access = true;
      });
    }
    else
    {
      setState(() {
        has_access = false;
      });
    }
  }

  void initState(){
    get_access(p.mode);
  }

  Widget build(BuildContext context) {
    // return ListVie;
    final args = ModalRoute.of(context)!.settings.arguments;
    String postedcomment = "";
    String postid = p.postid;
    // final fieldtext = TextEditingController();
    // print(args);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 197, 131, 207),
      ),
      drawer: Navbar(),
      body: Container(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.01),
          child :SingleChildScrollView(child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: CircleAvatar(backgroundImage: NetworkImage(p.ownerprofile),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.0 , right : 40.0),
                        child : Text(
                                p.postowner,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              )
                      ),
                      Text(
                        "posted on " + p.posteddate.substring(0,10),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.01,
                  ),
                  Text(
                    p.postdesc,
                    style: TextStyle(
                              fontFamily: "Opensans",
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                            ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height*0.02,
                  // ),
                  // const Text(
                  //       "3 Answers",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15.0
                  //       ),
                  //     ),
                  Divider(
                    height: MediaQuery.of(context).size.height*0.05,
                    thickness: 2,
                  ),
                  Visibility(
                    visible: has_access,
                    child :  TextFormField(
                        onChanged: (val){
                          postedcomment = val;
                        },
                        maxLines: 2,
                        // expands: true,
                        decoration: InputDecoration(
                          labelText: "Post Your Comment",

                        ),
                        textInputAction: TextInputAction.next,
                      ),
                  ),
                  Visibility(
                    visible: has_access,
                      child : ElevatedButton(
                        onPressed: ()async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String username = prefs.getString('username') ?? "";
                          String profilepic = prefs.getString('profilepic') ?? "";
                          String resp = await postcomment(postedcomment, p.postid, username, profilepic);
                          setState(() {
                            postid = p.postid;
                          });
                          // fieldtext.clear();
                        }, 
                        child: Text("Post"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green
                        ),
                      ),
                  ),
                  // Comments()
                  Comments(postid: p.postid,)
                ],
              ),
          )
            )
        );   
  }
}