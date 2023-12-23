import 'package:flutter/material.dart';
import 'package:shesafe/screens/login_screens/user.dart';
class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.user});
  final UserModel user;
  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context)=> ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Stack(
      alignment: Alignment.bottomRight,
      children:[ CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(widget.user.image),
      ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: widget.user.isOnline ? Colors.green : Colors.grey,radius: 5,
          ),
        )
      ]
    ),
    title: Text(widget.user.name,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text('Last Active: ${widget.user.lastActive}'),
  );
}
