import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/CommentScreen.dart';

import 'api.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged),

    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.red,
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(
           textTheme: ButtonTextTheme.primary,
          buttonColor: Colors.redAccent
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,

          iconTheme: IconThemeData(
            color: Colors.black
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 1
        )
      ),
      home: MySimpleApp(),
    );
  }
}

class MySimpleApp extends StatefulWidget {
  @override
  _MySimpleAppState createState() => _MySimpleAppState();
}

class _MySimpleAppState extends State<MySimpleApp> {

 // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider?.getCredential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final FirebaseUser user =
        (await _auth?.signInWithCredential(credential))?.user;
    print("signed in " + user?.displayName);
    return user;
  }

  Future<bool> _onSignIn() async {
    FirebaseUser user = await _handleSignIn();
    if (user != null) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseUser>(
      builder: (context,currentUser,child)=>currentUser==null?child:CommentScreen(),
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (rect) => LinearGradient(
                colors: [Colors.orange, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topLeft

              ).createShader(rect),
              blendMode: BlendMode.screen,
              child: Image.asset(
                "images/humans_wired.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,right: 0,
            top: MediaQuery.of(context).size.height*0.35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Text("Welcome to",style: TextStyle(color: Colors.white,fontSize: 11)),
                SizedBox(height: 12,),
                Text("Twiggle",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Sign In with :",style: TextStyle(color: Colors.white),),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8.0),
                    child: RaisedButton(

                      onPressed: _onSignIn,
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text("Google",style: TextStyle(fontSize: 18),)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                  ),


                ]
              ),
            ),
          )
        ],
      )),
    );
  }
}
