import 'package:flutter/material.dart';

import 'package:shesafe/screens/login_screens/login_screen.dart';
import 'package:local_auth/local_auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _authorized = 'Not Authorized';


  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }
  Future<void> _checkBiometrics() async {
    try {
    } catch (e) {
      print(e);
    }

    if (!mounted) return;


  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticate(
          localizedReason: 'Authenticate to access the app',
          options: const AuthenticationOptions(useErrorDialogs: false,stickyAuth: true));
    } catch (e) {
      print(e);
      authenticated = false;
    }

    if (!mounted) return;

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login screen
      );
    } else {
      setState(() {
        _authorized = 'Not Authorized';
      });
    }
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Weight Measurement Unit',style: TextStyle(fontSize: 20),),
                      Text('kg/g',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Length Measurement Unit',style: TextStyle(fontSize: 20),),
                      Text('cm/m',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Time Measurement Unit',style: TextStyle(fontSize: 20),),
                      Text('seconds',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _authenticate,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('App Info',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                Text('Click here to get help',style: TextStyle(fontSize: 20),)
                              ],
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.info_outline_rounded,size: 30,))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
