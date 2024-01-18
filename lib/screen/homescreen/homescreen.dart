import 'package:appwithfirebase/screen/add_screen.dart';
import 'package:appwithfirebase/screen/sign/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<QueryDocumentSnapshot> notes = [];
  getdata() async {
    QuerySnapshot querysnapshot =
        await FirebaseFirestore.instance.collection('notes').get();

    setState(() {
      notes.addAll(querysnapshot.docs);
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("firebase"),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn
                    .disconnect(); // hadi bach signout mn counte b google
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: Icon(Icons.exit_to_app_rounded)),
        ],
      ),
      body: GridView.builder(
        itemCount: notes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 150,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Card(
              color: Colors.grey[400],
              child: ListTile(
                title: Text(
                  "${notes[index]['note']}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
