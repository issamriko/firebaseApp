import 'package:appwithfirebase/screen/homescreen/homescreen.dart';
import 'package:appwithfirebase/screen/sign/login_screen.dart';
import 'package:appwithfirebase/screen/sign/widgets/custom_logo.dart';
import 'package:appwithfirebase/screen/sign/widgets/custom_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

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
            Column(
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "Login to continue",
                  style: TextStyle(fontSize: 16, color: Colors.purple),
                ),
              ],
            ),
            SizedBox(height: 40),
            Form(
              key: formstate,
              child: Column(
                children: [
                  Customformfield(
                    mycontroller: name,
                    hinttext: 'Enter Your Name',
                    suffixicon: Icon(null),
                    prefixicon: Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == "") {
                        return "can't to be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Customformfield(
                    mycontroller: email,
                    hinttext: 'Enter Your Email',
                    suffixicon: Icon(null),
                    prefixicon: Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == "") {
                        return "can't to be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Customformfield(
                    mycontroller: password,
                    hinttext: 'Enter your password',
                    suffixicon: Icon(Icons.visibility),
                    prefixicon: Icon(Icons.lock),
                    validator: (value) {
                      if (value == "") {
                        return "can't to be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
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
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  // ida textformfield vide
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homescreen(),
                        ),
                        (route) => false);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
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
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false);
                    },
                    child: Text("login now",
                        style: TextStyle(color: Colors.purple))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
