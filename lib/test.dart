/*import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'auth/android_auth_provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _signedIn = false;
  void _signIn() async {
    try {
      final creds = await AuthProvider().signInWithGoogle();
      setState(() {
        _signedIn = true;
      });
      print(creds);
    } catch (e) {
      print(e);
    }
  }
    void _signInWithFacebook() async {
       final creds = await AuthProvider().signInWithFacebook();
       _getUserData();
       return creds;
  }
 Map<String, dynamic> _userData;
  Future<void> _getUserData() async {
    _userData = await FacebookAuth.instance.getUserData(fields: "email,name,picture.width(300),birthday,friends");
  print(_userData);
  }
  void _signOut() async {
    try {
      await AuthProvider().signOut();
      setState(() {
        _signedIn = false;
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      _signedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (_signedIn)
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!_signedIn)
              Container(
                child: SignInButton(Buttons.Google,
                    text: "Sign up with Google", onPressed: _signIn),
              ),
            Container(
              child: SignInButton(
                Buttons.Facebook,
                text: "Sign up with Facebook",
                onPressed:  _signInWithFacebook,
              ),
            ),
            Text(prettyPrint(_userData)),
          ],
        ),
      ),
    );
  }
}
*/