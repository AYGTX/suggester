import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'auth/android_auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthProvider().initialize();
  runApp(MyApp());
}

String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _signedIn = false;
  AccessToken facebookUserCredentials;
  Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _checkLogin();

  }

// logout with google
  void _signOutWithGoogle() async {
    try {
      await AuthProvider().signOut();
      setState(() {
        _signedIn = false;
      });
    } catch (e) {
      print(e);
    }
  }

//check facebook login
  Future<void> _checkLogin() async {
    await Future.delayed(Duration(seconds: 1));
    facebookUserCredentials = await FacebookAuth.instance.isLogged;
    if (facebookUserCredentials != null) {
      await _getUserData();
    }
  }

  Future<void> _getUserData() async {
    _userData = await FacebookAuth.instance
        .getUserData(fields: "email,name,picture.width(300),birthday,friends");
  }

  Future<void> _loginWithFacebook() async {
    try {
      facebookUserCredentials = await FacebookAuth.instance.login();
      await _getUserData();
      print(
        facebookUserCredentials.toJson(),
      );
      setState(() {
        _signedIn=true;
      });
    } catch (e) {
      if (e is FacebookAuthException) {
        switch (e.errorCode) {
          case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
            print("FacebookAuthErrorCode.OPERATION_IN_PROGRESS");
            break;
          case FacebookAuthErrorCode.CANCELLED:
            print("FacebookAuthErrorCode.CANCELLED");
            break;

          case FacebookAuthErrorCode.FAILED:
            print("FacebookAuthErrorCode.FAILED");
            break;
        }
      }
    }
  }

  void _signOut() {
    if (facebookUserCredentials != null) {
      _logOut();
    } else {
      _signOutWithGoogle();
    }
    setState(() {
      _signedIn = false;
    });
  }

  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    setState(() {
      facebookUserCredentials = null;
      _signedIn=false;
    });
  }
String cred;
// login with google
  void _signInWithGoogle() async {
    try {
       cred= await AuthProvider().signInWithGoogle();
      
      setState(() {
        _signedIn = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to suggester"),
        actions: [
          if (_signedIn == true)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: _signOut,
                child: Icon(Icons.logout),
              ),
            ),
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_signedIn == false)
                SignInButton(
                  Buttons.Facebook,
                  onPressed: _loginWithFacebook,
                ),
                if (_signedIn == false)
              SignInButton(
                Buttons.Google,
                onPressed: _signInWithGoogle,
              ),
              if(facebookUserCredentials != null)
              Text(prettyPrint(_userData)),
              if(_signedIn==true)
              Text(cred)
            ],
          ),
        ),
      ),
    );
  }
}
