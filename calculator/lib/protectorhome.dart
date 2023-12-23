import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shesafe/screens/login_screens/login_screen.dart';

class ProtectorHome extends StatefulWidget {
  const ProtectorHome({super.key});

  @override
  State<ProtectorHome> createState() => _ProtectorHomeState();
}

class _ProtectorHomeState extends State<ProtectorHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final User? user = _auth.currentUser;
    if (user != null) {
      _userId = user.uid;
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // Navigate back to the login screen after logout
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Welcome Protector',style: TextStyle(color: Colors.white, fontSize: 20),),
        actions: [
          ElevatedButton(onPressed: (){
            _signOut(context);
          }, child: Icon(Icons.login,)),
        ],
      ),
      body: Center(child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Container(
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                  color: Colors.pink.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Need help in academic block 1',style: TextStyle(fontSize: 20),),
                      Text('Request Sent by: Nishika',style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){}, child: Text('Review Request'))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Container(
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                  color: Colors.pink.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Somebody was following me',style: TextStyle(fontSize: 20),),
                      Text('Request Sent by: Neha',style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){}, child: Text('Review Request'))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Container(
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                  color: Colors.pink.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Ragging in hostel',style: TextStyle(fontSize: 20),),
                      Text('Request Sent by: Sreenidhi',style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){

                      }, child: Text('Review Request'))
                    ],
                  ),
                ),
              ),
            ),
          ),



        ],
      )),
    );
  }
}
