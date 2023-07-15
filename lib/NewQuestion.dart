// ignore: file_names
import 'package:flutter/material.dart';
import 'package:quora_clone/navbar.dart';
import 'Apicalls.dart';

class NewQuestion extends StatefulWidget {
  const NewQuestion({super.key});

  @override
  State<NewQuestion> createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuestion> {
  bool teacher = false;
  bool all = true;
  String msg = "";
  bool notify = false;
  bool iserror = false;
  String desc = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: Navbar(),
      body: Form(
        child: Container(
          child: Column(
            children: [
              Visibility(
                visible: notify,
                child : Center(
                  child: Text(
                    msg,
                    style: TextStyle(
                      color: iserror ? Colors.red : Colors.green,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
              TextField(
                onChanged: (val){
                  desc = val;
                  setState(() {
                    notify = false;
                  });
                },
                  decoration: InputDecoration( 
                      labelText: "Question", //babel text
                      hintText: "Post Your Question", //hint text
                      prefixIcon: Icon(Icons.question_answer_outlined , size: 45,), //prefix iocn
                      hintStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold), //hint text style
                      labelStyle: TextStyle(fontSize: 18, ), //label style
                  ),
                // maxLength: 6, 
                maxLines: 6,
                // expands: true,        
              ),
             SizedBox(
              height: MediaQuery.of(context).size.height*0.04,
             ),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        teacher = true;
                        all = false;
                        // role = "teacher";
                      });
                    }, 
                    icon: Icon(
                      Icons.school,
                      size: 36,
                      color: teacher ? Colors.green : Colors.black,
                    ),
                    
                  ),
                  IconButton(
                    style: ElevatedButton.styleFrom(

                    ),
                    onPressed: (){
                      setState(() {
                        teacher = false;
                        all = true;
                        // role = "student";
                      });
                    }, 
                    icon: Icon(
                      Icons.person,
                      size: 36,
                      color: all ? Colors.green : Colors.black,
                    ),
                  )
                ],
              ),
             SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
             ),
             ElevatedButton(
              onPressed: ()async{
                String message = await postquestion(teacher ? "teacher" : "all", desc);
                if(message == "successfully posted")
                {
                  setState(() {
                    msg = message;
                    notify = true;
                  });
                }
                else
                {
                  setState(() {
                    msg = message;
                    iserror = true;
                    notify = true;
                  });
                }
              }, 
              child: Text("Post"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              )
              )
              
            ],
          ),
        ),
      ),
    );
  }
}