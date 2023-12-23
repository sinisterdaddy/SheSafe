import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class ReportAbuse extends StatefulWidget {
  const ReportAbuse({Key? key});

  @override
  State<ReportAbuse> createState() => _ReportAbuseState();
}

class _ReportAbuseState extends State<ReportAbuse> {
  _launchURL() async {
    const url = 'https://drive.google.com/drive/folders/1jN_LW3r6AvKeI_ig9Y9yEYduf7CZDmFn?usp=sharing'; // Replace with the URL you want to open
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    if (pickedFile == null) return;

    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final reference = FirebaseStorage.instance.ref().child(path);

    // Upload file to Firebase Storage
    final UploadTask task = reference.putFile(file);

    // Update state and wait for the upload to complete
    setState(() {
      uploadTask = task;
    });

    await task.whenComplete(() {
      setState(() {
        uploadTask = null;
      });
      print('File uploaded successfully');
    }).catchError((error) {
      print('Failed to upload file: $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              ElevatedButton(
                onPressed: () {
                  _launchURL();
                },
                child: Text('Upload Video Proof'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
