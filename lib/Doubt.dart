import 'package:flutter/material.dart';
import 'package:quora_clone/DoubtExpanded.dart';
import 'Utils.dart';

class Doubt extends StatelessWidget {
  Post p;
  Doubt({required this.p});
  // Question doubt;
  // Doubt({required this.doubt});
  // bool is_true = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      
      // margin: EdgeInsets.symmetric(vertical : 0 , horizontal : MediaQuery.of(context).size.width*0.1),
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 , left: MediaQuery.of(context).size.width*0.05 , top: MediaQuery.of(context).size.height*0.04),
      elevation: 6,
      // color: is_true ? Colors.amberAccent : Colors.blueAccent,
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) =>DoubtExpanded(p: p,)),
            // arguments: p.postid
          );
        },
        child : Container(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.01),
          decoration: const BoxDecoration(
            // color : Color.fromARGB(255, 211, 212, 212),
            // borderRadius: BorderRadius.circular(36.0)
          ),
          // width: MediaQuery.of(context).size.width*0.8,
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(p.ownerprofile),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0 , right : 50.0),
                    child : Text(
                            p.postowner,
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          )
                  ),
                  Text(
                    p.posteddate.substring(0,10),
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.005,
              ),
              Text(
                p.postdesc,
                style: TextStyle(
                  fontFamily: "Opensans",
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}