import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'auth_provider_base.dart';

class _AndroidAuthProvider implements AuthProvideBase {
  @override
  Future<FirebaseApp> initialize() async {
    return await Firebase.initializeApp(
        name: "login",
        options: FirebaseOptions(
          appId: "1:779092832374:android:7727688d9bfe15460c6f57",
          apiKey: "AIzaSyAot0iM1tsMKouVov0lJ4PFr82J4xsaqAg",
          messagingSenderId: "779092832374",
          projectId: "appauth-e95cd",
        ));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  
  @override
  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succeeded: $user');
      return '$user';
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }

  @override
  Future<bool> isSignedIn() async {
    return await GoogleSignIn().isSignedIn();
  }

  @override
  Future<void> signInWithFacebook() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login();
      print(await FacebookAuth.instance
          .getUserData(fields: "email,name,picture"));
      return accessToken;
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signOutWithFacebook() async {
    return await FacebookAuth.instance.logOut();
  }

  /* Future<void> _getUserDataGoogle() async {
final GoogleSignInAuthentication googleAuth =await googleUser.authentication;
return user;
  }*/

}

class AuthProvider extends _AndroidAuthProvider {}
