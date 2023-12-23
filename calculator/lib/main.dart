import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:shesafe/screens/calculator.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shesafe/screens/home_screen.dart';
import 'package:shesafe/screens/login_screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shesafe/twilio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
 MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _handleAuth());
  }

  Widget _handleAuth() {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator if the connection is in progress
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            // User is already logged in, navigate to home screen
            return HomeScreen();
          } else {
            // User is not logged in, redirect to login screen
            return LoginScreen();
          }
        }
      },
    );
  }
}
class APICall extends StatefulWidget {
  @override
  _APICallState createState() => _APICallState();
}

class _APICallState extends State<APICall> {
  late TextEditingController _adhaarController;
  @override
  void initState() {
    super.initState();
    _adhaarController = TextEditingController();
  }
  @override
  void dispose() {
    _adhaarController.dispose();

    super.dispose();
  }

  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  String result = ''; // To store the result from the API call

  Future<void> _postData() async {
    try {
      final response = await http.post(
        Uri.parse("http://20.0.27.38:5000/verifyAadhaar"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "aadhar_number": _adhaarController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          result = 'ID: ${responseData['gender']}';
        });

        if (responseData['gender'] == 'FEMALE') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verify your Adhaar'),
            TextField(
              textAlign: TextAlign.center,
              controller: _adhaarController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                hintText: "Enter your Adhaar",
                fillColor: Colors.white70,
              ),
            ),
            ElevatedButton(
              onPressed:_postData,
              child: Text('Submit'),
            ),
            SizedBox(height: 20.0),
            Text(
              result,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

