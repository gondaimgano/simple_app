import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/AddComment.dart';
import 'package:simple_app/Comment.dart';
import 'package:simple_app/db.dart';
import 'package:simple_app/showSettings.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseService.listOfComments(),
      initialData: [CommentItem(
        comment: "Loading...",
        username: "",
        dateCreated: "",
        key: ""
      )],
      child: Consumer<List<CommentItem>>(
        builder: (context, comments, child) => Scaffold(
          appBar: AppBar(
            elevation: 1 ,
            title: Text("Twiggle",style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            actions: <Widget>[IconButton(
              icon: Icon(Icons.person_outline,color: Colors.black,),
              onPressed: () async{
                await showSettings(context);
              },
            ),
              IconButton(
                icon: Icon(Icons.help_outline,color: Colors.black,),
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                },
              )],
          ),
          body: ListView(
            children: <Widget>[
              ...comments?.map(
                (item) => ListTile(
                  title: Text(item.comment),
                  subtitle: Text(item.username),
                  leading: Icon(
                    Icons.bookmark_border,
                    color: Colors.black,

                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>AddComment()
                )
              );
            },

            child: Icon(Icons.mail_outline,color: Colors.black,),
          ),
        ),
      ),
    );
  }
}
