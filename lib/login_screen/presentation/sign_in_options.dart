import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
  UserCredential user =
      await FirebaseAuth.instance.signInWithCredential(credential);
  print(user.user?.displayName);

  return user;
}

Future<UserCredential?> faceBookSignIn() async {
  try {
    final result =
        await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
    print(result.message);
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.i.getUserData();
      print(userData);
    }
    AuthCredential authCredential = FacebookAuthProvider.credential(result.accessToken!.token);
   UserCredential user=await FirebaseAuth.instance.signInWithCredential(authCredential);
    return user;
  } catch (error) {
    print(error);
    return null;
  }
}
