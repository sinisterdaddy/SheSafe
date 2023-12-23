import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';

import 'calculator.dart';

class EmergencyPage extends StatefulWidget {
   EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  final String apiU = 'http://192.168.137.138:5000/send_alert'; // Replace with your Flask API endpoint
  final String fixedRecipientNumber = '+916303082900';
  final quickActions = QuickActions();
  @override
  void initState(){
    super.initState();
    quickActions.setShortcutItems([
      ShortcutItem(type: 'LOW', localizedTitle: 'LOW') ,
      ShortcutItem(type: 'HIGH', localizedTitle: 'HIGH'),
      ShortcutItem(type: 'SEVERE', localizedTitle: 'SEVERE'),
    ]);
    quickActions.initialize((type) {
      if(type=='LOW')
      {
        sendAlert();
      }
      if(type=='HIGH')
      {
        makeEmergencyCall();
      }
      if(type=='SEVERE')
      {
        sendAlert();
        makeEmergencyCall();
      }

    });
  }



  http.Client client = http.Client();

  Future<void> sendAlert() async {
    try {
      final response = await http.post(
        Uri.parse(apiU),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'recipient_number': fixedRecipientNumber}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final messageSid = data['message_sid'];

        // Handle success, you can display a message or take further actions
        print('Alert message sent to fixed recipient. SID: $messageSid');
      } else {
        // Handle error
        print('Failed to send alert: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }


  final String apiUrl = 'http://192.168.137.138:5000/make_call'; // Replace with your Flask API endpoint
  Future<void> makeEmergencyCall() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '{}', // An empty JSON object as the body
      );

      if (response.statusCode == 200) {
        // Handle success, you can display a message or take further actions
        print('Emergency call initiated.');
      } else {
        // Handle error
        print('Failed to make the emergency call. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:  EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Column(
            children: [
            Text(
            'Current Location',
              style: TextStyle(
                color: Color(0xffb20202),
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children:  [
                Icon(
                  Icons.location_on,
                  size: 17,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Jaipur ,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'India',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>CalculatorApplication()));
                },
                icon: Icon(Icons.calculate_outlined,size: 40,)
            ),
          ],
        ),
            SizedBox(height: 10,),
            Text('EMERGENCY',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Center(child: Text('The type of severity you select will act and inform the respective authorities',style: TextStyle(fontSize: 15,),)),
             SizedBox(
              height: 10,
            ),


            //LOW

            GestureDetector(
              onTap: (){
                sendAlert();
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius:
                   BorderRadius.all(Radius.circular(40)),
                ),
                child:  Center(
                  child: Text(
                    'LOW',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
             SizedBox(
              height: 20,
            ),

            //high

            GestureDetector(
              onTap: (){
                makeEmergencyCall();
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius:
                   BorderRadius.all(Radius.circular(40)),
                ),
                height: 150,
                child:  Center(
                  child: Text(
                    'HIGH',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
             SizedBox(
              height: 20,
            ),


            //severe

            GestureDetector(
              onTap: (){
                sendAlert();
                makeEmergencyCall();

              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius:
                   BorderRadius.all(Radius.circular(40)),
                ),
                height: 150,
                child:  Center(
                  child: Text(
                    'SEVERE',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
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
