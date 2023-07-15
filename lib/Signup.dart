import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'dart:convert';
import 'dart:math';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String username = "";
  String email = "";
  String Password = "";
  // String profilepic = "";
  bool is_teacher = false;
  String errormsg = "";
  bool is_error = false;
  bool is_student = false;
  String role = "";
  List<String> profiles = [
    'https://cache.bmwusa.com/cosy.arox?pov=walkaround&brand=WBBM&vehicle=23SO&client=byo&paint=P0300&fabric=FMAH7&sa=S01RF,S0302,S0319,S0322,S03AG,S03MC,S03MQ,S0420,S0423,S0493,S04MC,S0552,S05AS,S05AV,S0688,S06AC,S06AK,S06C4,S06U3&quality=70&bkgnd=transparent&resp=png&angle=60&w=10000&h=10000&x=0&y=0',
    'https://www.dogbible.com/_ipx/f_png,q_80,fit_cover,s_1536x1536/dogbible/i/en/brown-labrador.png',
    'https://images.unsplash.com/photo-1606391276068-d82696ac76bc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGFicmFkb3IlMjBwdXBweXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
    'https://www.purina.co.uk/sites/default/files/styles/square_medium_440x440/public/2022-09/german%20shepherd.jpg?h=36f95f45&itok=Z-qlpOCv',
    'https://www.thesprucepets.com/thmb/NBwiR-vZvqzdtqHWtTIqRekud-8=/2119x0/filters:no_upscale():strip_icc()/GettyImages-978711748-39cc1126c08c42eca3a4a255c1bb50ef.jpg',
    'https://www.motortrend.com/uploads/2022/09/2023-Audi-Q7-front-three-quarter-view-42.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Mercedes-Benz_W223_IMG_6663.jpg/1200px-Mercedes-Benz_W223_IMG_6663.jpg',
    'https://stimg.cardekho.com/images/carexteriorimages/930x620/Mercedes-Benz/S-Class/7994/1633596468711/front-left-side-47.jpg',
    'https://imgd.aeplcdn.com/1280x720/n/cw/ec/56265/f-pace-exterior-right-front-three-quarter-2.jpeg?q=75',
    'https://images.moneycontrol.com/static-mcnews/2022/11/Range-Rover-2022.jpg'
  ];
  String name = "Test";

  Future<void> Signup() async {
    int index = Random().nextInt(10);
    String profilepic = profiles[index];
    final client = RetryClient(http.Client());
    print("un - $username----email - $email---role - $role");
    try {
        var response = await client.post(
            Uri.https('college-hub-service.onrender.com', 'auth/createuser'),
            body: {'username': username, 'password': Password , 'profilepic' : profilepic , 'role' : role , 'email' : email}
        );
        Map res = jsonDecode(response.body);
        // print(res);
        if(res['success'])
        {
          Navigator.popAndPushNamed(context, '/');
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

  void choose_user_role(){
    if(email != "")
    {
      if(email.codeUnitAt(0) <= 57)
      {
        setState(() {
            is_teacher = false;
            is_student = true;
            role = "student";
        });
      }
      else
      {
        setState(() {
            is_teacher = true;
            is_student = false;
            role = "teacher";
        });
      }
    }
    else
    {
      setState(() {
            is_teacher = false;
            is_student = true;
            role = "student";
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 197, 131, 207),
      ),
      body: SingleChildScrollView(child: Form(
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
                  email = val;
                  choose_user_role();
                  if(is_error)
                  {
                    setState(() {   
                      // errormsg = "Incorrect Details";
                      is_error = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter your email address",
                ),
                textInputAction: TextInputAction.done,
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
                height: MediaQuery.of(context).size.height*0.02,
              ),
              // TextFormField(
              //   onChanged: (val){
              //     profilepic = val;
              //     if(is_error)
              //     {
              //       setState(() {   
              //         // errormsg = "Incorrect Details";
              //         is_error = false;
              //       });
              //     }
              //   },
              //   decoration: InputDecoration(
              //     labelText: "Enter your Profilepic link",
              //   ),
              //   textInputAction: TextInputAction.done,
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height*0.02,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      // setState(() {
                      //   is_teacher = true;
                      //   is_student = false;
                      //   role = "teacher";
                      // });
                    }, 
                    icon: Icon(
                      Icons.school,
                      size: 36,
                      color: is_teacher ? Colors.green : Colors.black,
                    ),
                    
                  ),
                  IconButton(
                    style: ElevatedButton.styleFrom(

                    ),
                    onPressed: (){
                      // setState(() {
                      //   is_teacher = false;
                      //   is_student = true;
                      //   role = "student";
                      // });
                    }, 
                    icon: Icon(
                      Icons.person,
                      size: 36,
                      color: is_student ? Colors.green : Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              ElevatedButton(
                onPressed: (){
                  
                  Signup();
                },
                child: Text("Signup"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}