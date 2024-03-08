import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:start_up_project/core/utils/StoreAccessToken.dart';
import '../domain/login_repository.dart';
import 'loginDto.dart';


class FirebaseRepository implements AuthRepository {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );
      SecureStorage().writeSecureData("access_token", credential.accessToken);
     print( SecureStorage().readSecureData("access_token"));

      final user=await _firebaseAuth.signInWithCredential(credential);
      print(user);
      return user;

    } catch (e) {
      print('Google sign-in error: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        print(userData);
      }
      else{
        print("error");
      }
      final AuthCredential authCredential = FacebookAuthProvider.credential(
        result.accessToken!.token,
      );
      final user=await _firebaseAuth.signInWithCredential(authCredential);
      SecureStorage().writeSecureData("access_token", authCredential.accessToken);
      return user;
    } catch (e) {
      print('Facebook sign-in error: $e');
      return null;
    }
  }

  @override
  Future<LoginDto?> signInEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await  FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        return LoginDto(
          uid: user.uid,
          email: user.email,
          displayName: user.displayName,
          tokenID:await user.getIdToken(true).toString(),
          refreshToken: user.refreshToken ?? '',
        );
      }
    } catch (e) {
      debugPrint('Login failed: $e');
    }

    return null;
  }
}
