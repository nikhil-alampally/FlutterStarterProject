import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:start_up_project/core/utils/StoreAccessToken.dart';
import 'package:start_up_project/core/utils/color_constants.dart';
import 'package:start_up_project/core/utils/string_constants.dart';
import 'package:start_up_project/ui.dart';
import '../../core/utils/paddings.dart';
import '../domain/login_use_case.dart';
import 'login_validations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key,required this.authUseCase});
  final AuthUseCase authUseCase;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final accessToken=SecureStorage().readSecureData("access_token");
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var email = "";
  var password="";
  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Container(
        width: screenWidth,
        height: screenHeight,
        color: ColorConstants.backgroundColor,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.fromLTRB(0, 280, 0, 0),
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                ),
              ),
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: Paddings.forty,
                  ),
                  const Text(
                    StringConstants.login,
                    style: TextStyle(fontSize: 28),
                  ),
                  const SizedBox(
                    height: Paddings.twenty,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextField(
                          controller: emailController,
                          onChanged: (String value) {
                            setState(() {
                              email = value;
                              _isEmailValid = value.isNotEmpty;
                              _isEmailValid =
                                  emailValidation(enteredText: value);
                            });
                          },
                          labelText: StringConstants.email,
                          hintText: StringConstants.enterEmail),
                      email.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                              child: Text(
                                  _isEmailValid
                                      ? ""
                                      : StringConstants.enterValidEmail,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.red),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis))
                          : const Wrap()
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextField(
                        obscureText: passwordVisibility,
                        labelText: StringConstants.password,
                        hintText: StringConstants.enterPassword,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            icon: Icon(passwordVisibility
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        controller: passwordController,
                        onChanged: (String value) {
                           password=value;
                          setState(() {
                            _isPasswordValid = value.isNotEmpty;
                          });
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child: Text(
                            passwordValidation(
                                        enteredText: passwordController.text,
                                        isPasswordValid: _isPasswordValid) ==
                                    null
                                ? ""
                                : passwordValidation(
                                        enteredText: passwordController.text,
                                        isPasswordValid: _isPasswordValid)
                                    .toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.red),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ))
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(Paddings.twenty),
                      width: MediaQuery.of(context).size.width,
                      child: customButton(
                          () {},
                          const Text(
                            StringConstants.login,
                            style: TextStyle(color: Colors.white),
                          ))),
                  const SizedBox(
                    height: Paddings.forty,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      socialButtonCircle(
                          assetName: 'assets/facebook.png',
                          onTap: () {
                            setState(() {});
                            widget.authUseCase.signInWithFacebook();
                      /*      faceBookSignIn();*/
                          }),
                      const SizedBox(
                        width: Paddings.forty,
                      ),
                      socialButtonCircle(
                          assetName: 'assets/google.png',
                          onTap: () {
                            setState(() {});
                            widget.authUseCase.signInWithGoogle();
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )
      ),
      bottomNavigationBar: BottomAppBar(
          color: CupertinoColors.white,
          elevation: 0,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: StringConstants.account),
                TextSpan(
                    text: StringConstants.signUp,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      widget.authUseCase.signInEmailPassword(email, password);

                      }),
              ],
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});


  @override
  State<LoginScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LoginScreen> {
  final accessToken=SecureStorage().readSecureData("access_token");
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var email = "";
  var password="";
  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.fromLTRB(0, 280, 0, 0),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100.0),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: Paddings.forty,
                      ),
                      const Text(
                        StringConstants.login,
                        style: TextStyle(fontSize: 28),
                      ),
                      const SizedBox(
                        height: Paddings.twenty,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextField(
                              controller: emailController,
                              onChanged: (String value) {
                                setState(() {
                                  email = value;
                                  _isEmailValid = value.isNotEmpty;
                                  _isEmailValid =
                                      emailValidation(enteredText: value);
                                });
                              },
                              labelText: StringConstants.email,
                              hintText: StringConstants.enterEmail),
                          email.isNotEmpty
                              ? Padding(
                              padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                              child: Text(
                                  _isEmailValid
                                      ? ""
                                      : StringConstants.enterValidEmail,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.red),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis))
                              : const Wrap()
                        ],
                      ),
                      customTextField(hintText: "enter mobile number",labelText: "Mobile Number"),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextField(
                            obscureText: passwordVisibility,
                            labelText: StringConstants.password,
                            hintText: StringConstants.enterPassword,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisibility = !passwordVisibility;
                                  });
                                },
                                icon: Icon(passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            controller: passwordController,
                            onChanged: (String value) {
                              password=value;
                              setState(() {
                                _isPasswordValid = value.isNotEmpty;
                              });
                            },
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                              child: Text(
                                passwordValidation(
                                    enteredText: passwordController.text,
                                    isPasswordValid: _isPasswordValid) ==
                                    null
                                    ? ""
                                    : passwordValidation(
                                    enteredText: passwordController.text,
                                    isPasswordValid: _isPasswordValid)
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.red),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ))
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.all(Paddings.twenty),
                          width: MediaQuery.of(context).size.width,
                          child: customButton(
                                  () {},
                              const Text(
                                StringConstants.login,
                                style: TextStyle(color: Colors.white),
                              ))),
                      const SizedBox(
                        height: Paddings.forty,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          socialButtonCircle(
                              assetName: 'assets/facebook.png',
                              onTap: () {
                                setState(() {});
                                widget.authUseCase.signInWithFacebook();
                                /*      faceBookSignIn();*/
                              }),
                          const SizedBox(
                            width: Paddings.forty,
                          ),
                          socialButtonCircle(
                              assetName: 'assets/google.png',
                              onTap: () {
                                setState(() {});
                                widget.authUseCase.signInWithGoogle();
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: BottomAppBar(
          color: CupertinoColors.white,
          elevation: 0,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: StringConstants.account),
                TextSpan(
                    text: StringConstants.signUp,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        widget.authUseCase.signInEmailPassword(email, password);

                      }),
              ],
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}



