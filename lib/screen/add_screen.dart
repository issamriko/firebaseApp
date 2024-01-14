import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: text,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 1.7),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "enter your note",
                enabled: true,
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
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
    );
  }
}
