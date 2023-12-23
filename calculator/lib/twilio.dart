import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

void sendHelpMessage() async {
  String url = 'http://10.128.0.2:5000/send_help_message';

  Map<String, dynamic> data = {
    'recipient_number': '+919887551644', // Replace with the recipient's phone number
    'location_link': 'https://goo.gl/maps/pSQLYDuPe9XMCwb16', // Replace with the actual location URL
  };

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully');
      print(jsonDecode(response.body));
    } else {
      print('Failed to send message');
    }
  } catch (e) {
    print('Error: $e');
  }
}
class Twilio extends StatefulWidget {
  const Twilio({super.key});

  @override
  State<Twilio> createState() => _TwilioState();
}

class _TwilioState extends State<Twilio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ElevatedButton(onPressed: (){
        sendHelpMessage();
      }, child: Text('test')),
    );
  }
}
