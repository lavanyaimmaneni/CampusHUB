import 'package:flutter/material.dart';


class Post{
  String postid;
  String postowner;
  String postdesc;
  String posteddate;
  String mode;
  String ownerprofile;
  Post({required this.postdesc , required  this.posteddate , required this.postid, required this.postowner , required this.mode , required this.ownerprofile});
}

class Comments_class{
  String commentid;
  String commentdesc;
  String commentowner;
  String postid;
  String ownerprofile;
  String posteddate;
  int upvotes;
  int downvotes;
  Comments_class({required this.commentdesc , required this.commentid , required this.commentowner , required this.downvotes , required this.ownerprofile , required this.posteddate , required this.postid , required this.upvotes});
}

