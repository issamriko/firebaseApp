import 'package:appwithfirebase/screen/sign/widgets/custom_logo.dart';
import 'package:appwithfirebase/screen/sign/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey formstate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20),
            Customlogoauth(),
            SizedBox(height: 20),
            Form(
              key: formstate,
              child: Column(
                children: [
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Login to continue",
                    style: TextStyle(fontSize: 14, color: Colors.purple),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Enter Your Name",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.purple),
            ),
            SizedBox(height: 10),
            Customformfield(
              mycontroller: name,
              hinttext: 'Enter Your Name',
              suffixicon: Icon(null),
              prefixicon: Icon(Icons.email_outlined),
            ),
            SizedBox(height: 10),
            Text(
              "Email Address",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.purple),
            ),
            SizedBox(height: 10),
            Customformfield(
              mycontroller: email,
              hinttext: 'Enter Your Email',
              suffixicon: Icon(null),
              prefixicon: Icon(Icons.email_outlined),
            ),
            SizedBox(height: 20),
            Text(
              "Password",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.purple),
            ),
            SizedBox(height: 10),
            Customformfield(
              mycontroller: password,
              hinttext: 'Enter your password',
              suffixicon: Icon(Icons.visibility),
              prefixicon: Icon(Icons.lock),
            ),
            Container(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.purple),
                  ),
                )),
            MaterialButton(
              onPressed: () {},
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              height: 53,
              color: Colors.purple,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Colors.orange)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("have an account ? "),
                TextButton(onPressed: () {}, child: Text("login now")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
