import 'package:flutter/material.dart';

class UserModel{
  final String uid;
  final String name;
  final String email;
  final String image;
  final DateTime lastActive;
  final bool isOnline;
const UserModel({
    required this.uid,
    required this.email,
    required this.image,
    required this.lastActive,
    this.isOnline = false,
    required this.name,
});

factory UserModel.fromJson(Map<String,dynamic>json)=> 
UserModel(uid: json['uid'],
    email: json['email'],
    image: json['image'],
    lastActive: json['isActive'].toDate(),
    name: json['name'],isOnline: json['isOnline'] ?? false);

Map <String, dynamic> toJson()=> {
  'uid': uid,
  'name': name,
  'image': image,
  'email': email,
  'isOnline': isOnline,
  'lastActive': lastActive,
};

}

