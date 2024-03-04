import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:start_up_project/ui.dart';
import 'main.dart';

class StarterProject extends StatefulWidget {
  const StarterProject({super.key});

  @override
  State<StarterProject> createState() => _StarterProjectState();
}

class _StarterProjectState extends State<StarterProject> {
  final passwordController = TextEditingController();
  bool passwordVisibility = true;
  final myController = TextEditingController();
  bool _isPasswordValid = false;
  var emailValidation = RegExp(r'\S+@\S+\.\S+');
  bool _isValid = false;
   var email="";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SingleChildScrollView(child:  Container(
        width: screenWidth,
        height: screenHeight,
        color:Color(0xff0050b4),
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
                    height: 40,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 28),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  customTextField(
                      controller: myController,
                      onChanged: (String value) {
                        setState(() {
                          email=value;
                          _isValid = value.isNotEmpty;
                          _isValid = emailValidation.hasMatch(value);
                        });
                      },
                      labelText: "Email", hintText: 'Enter your email'),
                    email.isNotEmpty?
                    Padding(padding: EdgeInsets.fromLTRB(23, 0, 23, 0),
                        child:Text(_isValid?"":"Enter valid email",textAlign: TextAlign.start,style: TextStyle(fontSize: 13,color: Colors.red),maxLines: 1,overflow: TextOverflow.ellipsis)):Wrap()

                  ],),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                    customTextField(
                    obscureText: passwordVisibility,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            icon: Icon(
                                passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                    controller: passwordController,
                    onChanged: (String value) {
                      setState(() {
                        _isPasswordValid = value.isNotEmpty;
                      });
                    },
                  ),


                  Padding(padding: EdgeInsets.fromLTRB(23, 0, 23, 0),child: Text( passwordValidation(
                      enteredText: passwordController.text,
                      isPasswordValid: _isPasswordValid)==null?"":passwordValidation(
                      enteredText: passwordController.text,
                      isPasswordValid: _isPasswordValid).toString(),textAlign: TextAlign.start,style: TextStyle(fontSize: 13,color: Colors.red),maxLines: 1,overflow: TextOverflow.ellipsis,))],
            ),
                  Container(
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: customButton(
                          () {},
                          const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )
                      )
                  ),
                  SizedBox(height: 40,),
                  Row(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
                    socialButtonCircle(assetName: 'assets/facebook.png'),
                    SizedBox(width: 40,),
                    socialButtonCircle(assetName: 'assets/google.png')
                  ],)

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
                const TextSpan(text: "Don't have account ?"),
                TextSpan(
                    text: ' SignUp',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/starter');
                      }
                      ),
              ],
            ),
            textAlign: TextAlign.center,
          )
      ),

    );
  }
}
