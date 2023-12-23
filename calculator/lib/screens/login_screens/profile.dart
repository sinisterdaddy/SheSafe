import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _userId;
  late String _name = '';
  late String _phoneNumber = '';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

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

  Future<void> _addContact() async {
    try {
      await _firestore.collection('users').doc(_userId).collection('contacts').add({
        'name': _name,
        'phone_number': _phoneNumber,
      });
      _nameController.clear();
      _phoneNumberController.clear();
      // Fetch contacts after adding the new one
      setState(() {});
    } catch (e) {
      print('Error adding contact: $e');
    }
  }

  Widget _buildContactList() {
    return StreamBuilder(
      stream: _firestore.collection('users').doc(_userId).collection('contacts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final contacts = snapshot.data!.docs;
          List<Widget> contactWidgets = [];
          for (var contact in contacts) {
            final name = contact['name'];
            final phoneNumber = contact['phone_number'];
            contactWidgets.add(
              Padding(
                padding: EdgeInsets.all(5),

                // child: ListTile(
                //   title: Text(name),
                //   subtitle: Text(phoneNumber),
                // ),
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                    color: Colors.pink.shade100,
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                      Text(name.toUpperCase(),style: TextStyle(fontSize: 20),),Text(phoneNumber,style: TextStyle(fontSize: 20),),
                    ],),
                  ),
                ),
              ),
            );
          }
          return ListView(
            children: contactWidgets,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Contacts'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: _buildContactList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Contact'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      onChanged: (value) {
                        setState(() {
                          _phoneNumber = value;
                        });
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      _addContact();
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
