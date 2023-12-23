import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shesafe/protectorhome.dart';
import 'package:shesafe/screens/protector_signup.dart';
import 'package:shesafe/screens/signup_screen.dart';
import 'package:shesafe/test.dart';

import '../../utils/colors.dart';
import '../home_screen.dart';


class LoginProtector extends StatefulWidget {
  const LoginProtector({Key? key}) : super(key: key);

  @override
  State<LoginProtector> createState() => _LoginProtectorState();
}

class _LoginProtectorState extends State<LoginProtector> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(); // Initialize the _emailController
    _passwordController = TextEditingController(); // Initialize the _emailController
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  bool validateEmail(String email) {
    // Check if the email ends with 'vitap.ac.in'
    if (email.toLowerCase().endsWith('@vitap.ac.in')) {
      return true;
    } else {
      return false;
    }
  }


  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Navigate to the home screen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ProtectorHome()),
        );
      }
    } catch (e) {
      print('Failed to sign in: $e');
      // Handle sign-in failures, e.g., show an error message
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[bgColor1, bgColor2],
            tileMode: TileMode.mirror,
          ),
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [

                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'LOGIN  AS  PROTECTOR',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),


                const SizedBox(
                  height: 60,
                ),


                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    hintText: "Enter your email",
                    fillColor: Colors.white70,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    hintText: "Enter password",
                    fillColor: Colors.white70,
                  ),
                ),


                const SizedBox(
                  height: 30,
                ),


                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20)),
                    ),
                    onPressed: () {
                      _signInWithEmailAndPassword();
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                TextButton(
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(width: 5,),

                      Text(
                        'Get Help',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),



                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProtectorSignup()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(width: 5,),

                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),





              ],
            ),
          ),
        ),
      ),
    );
  }
}
