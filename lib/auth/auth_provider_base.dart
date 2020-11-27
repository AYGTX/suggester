import 'package:firebase_core/firebase_core.dart';
abstract class AuthProvideBase{
  Future<FirebaseApp> initialize();
  Future<String> signInWithGoogle();
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<void> signInWithFacebook();
  Future<void> signOutWithFacebook();
 // Future<User> _getUserDataGoogle();



}