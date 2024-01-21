import 'package:appwithfirebase/screen/homescreen/homescreen.dart';
import 'package:appwithfirebase/screen/sign/signup_screen.dart';
import 'package:appwithfirebase/screen/sign/widgets/custom_logo.dart';
import 'package:appwithfirebase/screen/sign/widgets/custom_textformfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool visible = true;
  //sign in with google
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Homescreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10),
            Customlogoauth(),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "Login to continue",
                  style: TextStyle(fontSize: 17, color: Colors.purple),
                ),
              ],
            ),
            SizedBox(height: 40),
            Form(
              key: formstate,
              child: Column(
                children: [
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
                    obscureText: visible,
                    suffixicon: InkWell(
                      child: visible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      borderRadius: BorderRadius.circular(40),
                    ),
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
                  onPressed: () async {
                    if (email.text == "") {
                      return AwesomeDialog(
                              context: context,
                              title: "errer",
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              desc: 'please enter your email address ')
                          .show();
                    } else {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                      AwesomeDialog(
                              context: context,
                              title: "errer",
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              desc:
                                  'go to your email address to reset your password')
                          .show();
                    }
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.purple),
                  ),
                )),
            MaterialButton(
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  isloading = true;
                  setState(() {});
                  try {
                    //credential hya user li dkhl email w password
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    isloading = false;
                    setState(() {});
                    if (credential.user!.emailVerified) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Homescreen(),
                          ),
                          (route) => false);
                    } else {
                      isloading = false;
                      setState(() {});
                      AwesomeDialog(
                        context: context,
                        title: "errer",
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        desc: "Please Verified Your Email",
                      ).show();
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      AwesomeDialog(
                        context: context,
                        title: "errer",
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        desc: "Not User found for that email",
                      ).show();
                    } else if (e.code == 'wrong-password') {
                      isloading = false;
                      setState(() {
                        
                      });

                      AwesomeDialog(
                              context: context,
                              title: "errer",
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              desc: 'Wrong password provided for that user.')
                          .show();
                    }
                  }
                }
              },
              child: isloading
                  ? CircularProgressIndicator()
                  : Text(
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
              children: [
                Expanded(
                    child: Divider(
                  indent: 20,
                  endIndent: 10,
                )),
                Text("OR"),
                Expanded(
                    child: Divider(
                  indent: 10,
                  endIndent: 20,
                )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                      size: 33,
                    )),
                IconButton(
                    onPressed: () {
                      signInWithGoogle();
                    },
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.orange,
                      size: 33,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.x,
                      color: Colors.black,
                      size: 33,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ? ",
                  style: TextStyle(fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                          (route) => false);
                    },
                    child: Text("register",
                        style: TextStyle(color: Colors.purple, fontSize: 18))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
