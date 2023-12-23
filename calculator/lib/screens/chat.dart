import 'package:flutter/material.dart';
import 'package:shesafe/screens/login_screens/user.dart';
import 'package:shesafe/screens/useritem.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final userData = [
    UserModel(uid: '1', email: 'abc@gmail.com', image: 'null', lastActive: DateTime.now(), name: 'Aryan'),
    UserModel(uid: '2', email: 'efg@gmail.com', image: 'null', lastActive: DateTime.now(), name: 'Saransh'),
    UserModel(uid: '3', email: 'hij@gmail.com', image: 'null', lastActive: DateTime.now(), name: 'Anas'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView.separated(
        itemCount: userData.length,
        separatorBuilder: (context,index)=>
        const SizedBox(height: 10,),
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context,index)=>
            UserItem(user: userData[index],),
      ),
    );
  }
}
