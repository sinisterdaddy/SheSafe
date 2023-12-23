import 'package:flutter/material.dart';
import 'package:shesafe/screens/signup_screen.dart';
import 'package:shesafe/utils/colors.dart';

import 'login_admin.dart';
import 'login_protector.dart';
import 'login_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                bgColor1,
                bgColor2
              ],
              tileMode: TileMode.mirror,
            ),
          ),

          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 60,),

                  Text(
                    'Login with your account',
                    style: TextStyle(
                      color: headingColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),

                  const SizedBox(height: 40,),

                  CircleAvatar(
                    radius: 70,
                    backgroundColor: headingColor,
                    backgroundImage: NetworkImage('https://github.com/LAG-4/engproj.github.io/blob/main/logo.png?raw=true'),

                  ),

                  const SizedBox(height: 10,),

                  Text(
                    'SheSafe',
                    style: TextStyle(
                      color: headingColor,
                      fontFamily: 'Montserrat',
                      fontSize: 30
                    ),
                  ),

                  const SizedBox(height: 50,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginUser()));
                      },
                      child: Text(
                        'Login As User',
                        style: TextStyle(
                          color: headingColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginProtector()));
                      },
                      child: Text(
                        'Login As Protector',
                        style: TextStyle(
                          color: headingColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
