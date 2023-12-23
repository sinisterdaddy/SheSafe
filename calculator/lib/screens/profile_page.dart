import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shesafe/chat.dart';
import 'package:shesafe/report.dart';
import 'package:shesafe/screens/login_screens/profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/colors.dart';
import 'login_screens/login_screen.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _getUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        // Use null-aware operator to safely access data
        return userDoc.data() as Map<String, dynamic>? ?? {};
      }
      return {};
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
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
  _launchURL() async {
    const url = 'https://sophia.chat/'; // Replace with the URL you want to open
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL2() async {
    const url = 'https://we-chat-sinisterdaddys-projects.vercel.app/'; // Replace with the URL you want to open
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL3() async {
    const url = 'https://drive.google.com/drive/folders/1jN_LW3r6AvKeI_ig9Y9yEYduf7CZDmFn?usp=sharing'; // Replace with the URL you want to open
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  Row(
                    children: [

                      const SizedBox(width: 20,),

                      const Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 30
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),


                  CircleAvatar(
                    radius: 52,
                    backgroundColor: headingColor,
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: FaIcon(FontAwesomeIcons.userLarge, color: Colors.black, size: 40,),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Container(
                    width: double.infinity,
                    height: 250,

                    child: FutureBuilder(
                      future: _getUserData(),
                      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text('No data available'),
                          );
                        } else {
                          final userData = snapshot.data!;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Verified User',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  FaIcon(FontAwesomeIcons.check, size: 20, color: Colors.green,),
                                ],
                              ),
                              const SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name:',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            // Display the user's name
                                            userData['fullName'] ?? '',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'E-mail id:   ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20
                                          ),
                                        ),
                                        Text(
                                          // Display the user's email
                                          userData['email'] ?? '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'College ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20
                                          ),
                                        ),
                                        Text(
                                          // Display the user's phone number
                                          userData['college'] ?? '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      _launchURL(); // Call the function to open the link

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(border: Border.all(width: 2),borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Chat with an AI',style: TextStyle(fontSize: 30),),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: IconButton(onPressed: (){}, icon: IconButton(onPressed: (){}, icon: Icon(Icons.chat_bubble,size: 35,))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      _launchURL2();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(border: Border.all(width: 2),borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Go to community chat',style: TextStyle(fontSize: 20),),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: IconButton(onPressed: (){}, icon: IconButton(onPressed: (){}, icon: Icon(Icons.person_2_rounded,size: 35,))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController urlController = TextEditingController();
                          TextEditingController descriptionController = TextEditingController();

                          return AlertDialog(
                            title: Text('Add Image'),
                            content: IntrinsicHeight(
                              child: Column(
                                children: [
                                  // Text field for URL
                                  TextField(
                                    controller: urlController,
                                    decoration: InputDecoration(labelText: 'Image URL'),
                                  ),
                                  // Text field for description
                                  TextField(
                                    controller: descriptionController,
                                    decoration: InputDecoration(labelText: 'Description'),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  // Access the values entered in the text fields
                                  String imageUrl = urlController.text;
                                  String description = descriptionController.text;

                                  // Handle the values as needed (e.g., validate, save, etc.)

                                  await FirebaseFirestore.instance.collection('review').add({
                                    'url': imageUrl,
                                    'description': description,
                                  });
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );

                      // _launchURL3();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(border: Border.all(width: 2),borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Upload abuse proof',style: TextStyle(fontSize: 20),),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: IconButton(onPressed: (){}, icon: IconButton(onPressed: (){}, icon: Icon(Icons.warning_rounded,size: 35,))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _signOut(context);
                      },
                      child: Text('LOGOUT',style: TextStyle(color: Colors.black),),
                    ),
                  )

                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
