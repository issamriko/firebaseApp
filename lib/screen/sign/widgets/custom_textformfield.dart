import 'package:flutter/material.dart';

class Customformfield extends StatelessWidget {
  final TextEditingController mycontroller;
  final String hinttext;
  final Widget suffixicon;
  final Widget prefixicon;
  const Customformfield(
      {super.key,
      required this.prefixicon,
      required this.mycontroller,
      required this.hinttext,
      required this.suffixicon});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == "") {
          return "can't to be empty";
        }
        return null;
      },
      controller: mycontroller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: hinttext,
        suffixIcon: suffixicon,
        prefixIcon: prefixicon,
        prefixIconColor: Colors.purple,
      ),
    );
  }
}
