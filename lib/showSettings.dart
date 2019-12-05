import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/api.dart';

Future showSettings(BuildContext context) async{
  await showTwiggleSheet(context);
}

Future showTwiggleSheet(BuildContext c) async{
  return showModalBottomSheet(context: c,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0))
      ),

      builder: (context){


    return Consumer<FirebaseUser>(
      builder: (context,model,child)=>
       Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 12,),
            Text("${model?.displayName??"Guest"}",style: Theme.of(context).textTheme.title,),
            SizedBox(height: 18,),
            ListTile(
              leading: Icon(Icons.people_outline),
              title: Text("About Us",),
              subtitle: Text("Twiggle is protected by the Pun Pun fun fun co company"),
            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text("Do you wish Logout ? ",),
              subtitle: Text("Please do not logout we still love you :)"),
              onTap: () async{
                await FirebaseAuth.instance.signOut().then((s){


                  googleSignIn.signOut();


                });

                Navigator.of(context).pop();
              },
            ),
            ListTile()
          ],
        ),
      ),
    );
  }
  );
}