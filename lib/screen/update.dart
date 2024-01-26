import 'package:appwithfirebase/screen/homescreen/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String docid;
  final String oldtext;
  const UpdateScreen({super.key, required this.docid, required this.oldtext});
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void initState() {
    super.initState();
    inputtext.text = widget.oldtext;
  }

  bool isloading = false;
  TextEditingController inputtext = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');
  Future<void> UpdateNotes() async {
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        await notes
            .doc(
          widget.docid,
        )
            .update({"note": inputtext.text});

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Homescreen(),
            ),
            (route) => false);
      } catch (e) {
        isloading = false;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: inputtext,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 1.7),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "enter your note",
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        UpdateNotes();
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10))),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
