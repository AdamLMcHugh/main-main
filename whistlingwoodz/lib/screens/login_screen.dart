// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whistlingwoodz/main.dart';
import 'package:whistlingwoodz/screens/registration_screen.dart';
import 'package:whistlingwoodz/utils/app_utils.dart';
import 'package:whistlingwoodz/widgets/input_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.data});
  final bool data;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        // ignore: prefer_const_constructors
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fix for pixel exceeding screen.
      resizeToAvoidBottomInset: false,
      backgroundColor: colorPrimary,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Padding(
            // padding around all edges of screen
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            // Bullet symbol
                            Container(
                              width: 20.0,
                              height: 10.0,
                              decoration: const BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 1.5,
                            ),
                            // Line under bullet symbol
                            Container(
                              width: 20.0,
                              height: 2.0,
                              decoration: const BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        // WhistlingWoodz Name
                        const Text(
                          "WhistlingWoodz",
                          style: TextStyle(
                            color: colorWhite,
                            fontSize: 25.0,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ],
                    ),
                    // Space between WhistlingWoodz name and welcome back
                    const SizedBox(
                      height: 25.0,
                    ),
                    // Welcome back! BOLD
                    const Text(
                      "Welcome back !",
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 25.0,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Space between welcome back and Please enter your details
                    const SizedBox(
                      height: 25.0,
                    ),
                    // Please enter you details below text
                    const Text(
                      "Please enter your details below",
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 14.0,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    // Email controller input field
                    InputField(
                      controller: emailController,
                      hintText: "Please enter your email",
                      icon: Icons.email,
                    ),
                    // Space between email and password fields
                    const SizedBox(
                      height: 25.0,
                    ),
                    // Password controller input field
                    InputField(
                      controller: passwordController,
                      hintText: "Please enter your password",
                      icon: Icons.password,
                      obsecureText: true,
                    ),
                    // Space between password field and Sign in button
                    const SizedBox(
                      height: 70.0,
                    ),
                    // Sign In button.

                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          // ignore: prefer_const_constructors
                          minimumSize: Size.fromHeight(50),
                        ),
                        // ignore: prefer_const_constructors
                        icon: Icon(Icons.lock, size: 32),
                        // ignore: prefer_const_constructors
                        label: Text(
                          'Sign In',
                          // ignore: prefer_const_constructors
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: signIn),
                    // Space between Sign In button and Don't have an account
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Don't have an account text
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: colorWhite,
                            fontFamily: fontFamily,
                          ),
                        ),
                        // Sign Up text
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: colorWhite,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidate() {
    if (emailController.text.isEmpty) {
      showScaffold(context, "Please enter your email");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showScaffold(context, "Please enter your password");
      return false;
    }
    return true;
  }
}
