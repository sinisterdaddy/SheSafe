import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shesafe/screens/calculator.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shesafe/screens/home_screen.dart';
import 'package:shesafe/screens/login_screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shesafe/screens/signup_screen.dart';

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
        Uri.parse("http://20.0.27.38:8000/verifyAadhaar"),
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
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        } else if (responseData['gender'] == 'MALE') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Not Allowed'),
                content: Text('Sorry, males cannot register.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
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

