import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prempranay/screens/profile.dart';
import 'package:prempranay/screens/profilecard.dart';

import 'package:prempranay/screens/sign_up.dart';
import 'package:prempranay/util.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
//   var querysnap;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchFirebaseData();
//   }
//     fetchFirebaseData()async{
//  querysnap =   await FirebaseFirestore.instance.collection("posts")
//     .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid )
//     .get();

//     if(querysnap?.docs.isNotEmpty){

//       Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileCard()));
//     }

//    }
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  signIn() async {
    if (emailController.text == "" || passwordController.text == "") {
      showDialogBox(context, true, "please fill all the fields");

      return;
//it wont move to try catch block at all
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showDialogBox(context, true, "Sign in successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
      //navigator dismiss dialog
      //  Navigator.pop(context);
    } catch (e) {
      showDialogBox(context, true, e.toString());
    }

    setState(() {
      emailController.text = "";
      passwordController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     automaticallyImplyLeading: false,
      //     centerTitle: true,
      //     title: myText("Sign In")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myText("Sign In"),
            myIcon(Icons.person),
            myTextField(false, "Email", emailController),
            myTextField(true, "Password", passwordController),
            myButton("Sign in", () {
              signIn();
              // if (nameController.text == "" ||
              //     emailController.text == "" ||
              //     passwordController.text == "") {
              //   print("fill up all the fields");
              // }
            }),
            myTextButton("Not signup in yet?", "Sign up now", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            }),
          ],
        ),
      ),
    );
  }
}
