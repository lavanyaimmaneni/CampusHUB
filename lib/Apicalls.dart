import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> postcomment(String commentdesc , String postid , String commentowner , String ownerprofile)async{
    final client = http.Client();
    String message = "";
    try {
        var response = await client.post(
            Uri.https('college-hub-service.onrender.com', 'comment/addcomment'),
            body: {
              'commentdesc' : commentdesc,
              'commentowner' : commentowner,
              'postid'      : postid,
              'ownerprofile' : ownerprofile
            }
        );
        Map res = jsonDecode(response.body);
        // print(res);
        message = res['msg'];
        // print(data['username']);
        
      }catch(e){
        print(e);
        message = "Error";
      } finally {
        client.close();
    }
    return message;
  }

  Future<String> postquestion(String mode , String postdesc) async{
    final client = http.Client();
    String message = "";
    try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String ownerprofile = prefs.getString('profilepic') ?? "";
        String postowner = prefs.getString('username') ?? "";
        print(postowner);
        var response = await client.post(
            Uri.https('college-hub-service.onrender.com', 'post/newpost'),
            body: {
              'mode' : mode,
              'postdesc' : postdesc,
              'ownerprofile' : ownerprofile,
              'username' : postowner
            }
        );
        Map res = jsonDecode(response.body);
        print(res);
        // print(res);
        message = res['msg'];
        // print(data['username']);
        
      }catch(e){
        print(e);
        message = "Error";
      } finally {
        client.close();
    }
    return message;
  }