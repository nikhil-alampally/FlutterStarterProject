import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:start_up_project/core/utils/string_constants.dart';
import 'package:start_up_project/login_screen/presentation/login_screen.dart';
import 'login_screen/data/login_repository_imp.dart';
import 'login_screen/domain/login_use_case.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: StringConstants.apiKey,
    // paste your api key here
    appId: StringConstants.appId,
    //paste your app id here
    messagingSenderId: StringConstants.messagingSenderId,
    //paste your messagingSenderId here
    projectId: StringConstants.projectId,
    //paste your project id here
  ));
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});
   final authUseCase=AuthUseCase(FirebaseRepository());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return
            LoginScreen(authUseCase: authUseCase);
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}

