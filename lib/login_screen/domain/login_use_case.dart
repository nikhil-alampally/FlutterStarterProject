import 'package:firebase_auth/firebase_auth.dart';
import '../data/loginDto.dart';
import 'login_repository.dart';



class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<UserCredential?> signInWithGoogle() async {
    return _authRepository.signInWithGoogle();
  }

  Future<UserCredential?> signInWithFacebook() async {
    return _authRepository.signInWithFacebook();
  }
  Future<LoginDto?> signInEmailPassword(String email, String password) async{
    return _authRepository.signInEmailPassword(email, password);
  }
}