import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  // this will catch any error, and print it on console.
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password reset link is sent! Check your email."),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e); //print on console,
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enter your email, we will send you password reset link.",
            style: GoogleFonts.josefinSans(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),

          //-----------------------------email textfield----------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'Email',
                fillColor: Colors.grey.shade200,
                filled: true,
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),

          //-----------------------------creating button------------------------
          MaterialButton(
            onPressed: passwordReset,
            // ignore: sort_child_properties_last
            child: Text(
              "Reset Password",
              style: GoogleFonts.josefinSans(color: Colors.white),
            ),
            color: Colors.grey.shade800,
          )
        ],
      ),
    );
  }
}
