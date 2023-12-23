import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shesafe/screens/home_screen.dart';
import 'package:shesafe/screens/login_screens/login_screen.dart';
import '../utils/colors.dart';

class ProtectorSignup extends StatefulWidget {
  const ProtectorSignup({Key? key}) : super(key: key);




  @override
  State<ProtectorSignup> createState() => _ProtectorSignupState();
}

class _ProtectorSignupState extends State<ProtectorSignup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _phonenumberController;
  late TextEditingController _departmentController;
  late TextEditingController _nameController;



  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phonenumberController = TextEditingController();
    _departmentController = TextEditingController();
    _nameController = TextEditingController();
  }
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phonenumberController.dispose();
    _departmentController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  Future<void> _registerWithEmailAndPassword() async {
    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      // If passwords don't match, show an error alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // If passwords match, proceed with registration
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Registration successful, save user data to Firestore
        await _firestore.collection('protector').doc(userCredential.user!.uid).set({
          'fullName': _fullNameController.text.toUpperCase(),
          'email': _emailController.text,
          'phone': _phonenumberController.text,
          'department': _departmentController.text,

        });
      String  test= _fullNameController.text.toUpperCase();
      String dep = _departmentController.text.toUpperCase();
        await _firestore.collection('colleges').doc(test).collection(dep).add({
          'email': _emailController.text,
          'phone': _phonenumberController.text

        });
        await _firestore.collection('colleges').doc(test).set({
          'userId': _fullNameController.text.toUpperCase(),

        });

        // Navigate to home screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } catch (e) {
      print('Failed to register: $e');
      // Handle registration failures, e.g., show an error message
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
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
                    height: 40,
                  ),
                  const Text(
                    'SIGN UP AS PROTECTOR',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      hintText: "Enter University Name",
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      hintText: "Enter email",
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ), TextField(
                    textAlign: TextAlign.center,
                    controller: _phonenumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      hintText: "Enter Phone number",
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: _departmentController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      hintText: "Enter Your Department",
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: _passwordController,
                    obscureText: true,
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
                    height: 10,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      hintText: "Confirm password",
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
                        _registerWithEmailAndPassword();
                      },
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 15,),
        
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
        
                        SizedBox(width: 5,),
        
                        Text(
                          'Log In',
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
      ),

    );
  }
}
