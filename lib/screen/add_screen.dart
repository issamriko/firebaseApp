import 'package:appwithfirebase/screen/homescreen/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController inputtext = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');
  Future<void> addNotes() async {
    if (formState.currentState!.validate()) {
      try {
        await notes.add(
          {
            'note': inputtext.text,
          },
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Homescreen(),
            ),
            (route) => false);
      } catch (e) {
        print("errer$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                    borderSide: BorderSide(color: Colors.purple, width: 1.7),
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
                  addNotes();
                },
                child: Text(
                  "add",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 10))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
