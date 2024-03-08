import 'package:firebase_auth/firebase_auth.dart';

import '../data/loginDto.dart';

abstract class AuthRepository {
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithFacebook();
  Future<LoginDto?> signInEmailPassword(String email, String password);
}