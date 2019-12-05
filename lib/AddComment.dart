import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/Comment.dart';
import 'package:simple_app/db.dart';




class AddComment extends StatefulWidget {
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {

  TextEditingController _controller;

  @override
  void initState() {
    _controller=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.close,),
        onPressed: (){
          Navigator.of(context).pop();
        },

        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              var user=await FirebaseAuth.instance.currentUser();

              await DatabaseService.createComment(CommentItem(
                comment: _controller.text,
                dateCreated: DateTime.now().millisecondsSinceEpoch.toString(),
                username: user.displayName
              ));

              Navigator.of(context).pop();
            },
            icon: Icon(Icons.done_outline),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 22,),
              textInputAction: TextInputAction.done,
              maxLines: 20,
              decoration: InputDecoration.collapsed(hintText: null),
              controller: _controller,
              maxLength: 100,
              keyboardType:TextInputType.multiline,
              keyboardAppearance: Brightness.dark,
            ),
          ),
        ),
      ),
    );
  }
}
