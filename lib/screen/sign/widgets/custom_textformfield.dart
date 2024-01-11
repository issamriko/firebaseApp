import 'package:flutter/material.dart';

class Customformfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController mycontroller;
  final String hinttext;
  final Widget suffixicon;
  final Widget prefixicon;
  const Customformfield(
      {super.key,
      required this.prefixicon,
      required this.mycontroller,
      required this.hinttext,
      required this.suffixicon,
      required this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
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
