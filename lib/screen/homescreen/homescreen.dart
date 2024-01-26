import 'package:appwithfirebase/screen/add.dart';
import 'package:appwithfirebase/screen/sign/login_screen.dart';
import 'package:appwithfirebase/screen/update.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isloading = true;
  List<QueryDocumentSnapshot> notes = [];
  getdata() async {
    QuerySnapshot querysnapshot = await FirebaseFirestore.instance
        .collection('notes')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    notes.addAll(querysnapshot.docs);
    isloading = false;
    setState(() {});
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
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: notes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 150,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    AwesomeDialog(
                            context: context,
                            title: "warning",
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            btnCancelOnPress: () async {
                              await FirebaseFirestore.instance
                                  .collection('notes')
                                  .doc(notes[index].id)
                                  .delete();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homescreen(),
                                  ),
                                  (route) => false);
                            },
                            btnCancelText: "delete",
                            btnOkText: "update",
                            btnOkOnPress: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateScreen(
                                        oldtext: notes[index]['note'],
                                        docid: notes[index].id),
                                  ));
                            },
                            desc: 'select what do you want ')
                        .show();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Card(
                      color: Colors.grey[400],
                      child: ListTile(
                        title: Text(
                          "${notes[index]['note']}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
