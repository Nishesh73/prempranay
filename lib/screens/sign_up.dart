import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prempranay/screens/profile.dart';
import 'package:prempranay/screens/profilecard.dart';
import 'package:prempranay/screens/profilecardwidget.dart';
import 'package:prempranay/screens/sign_in.dart';
import 'package:prempranay/util.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

// var querysnap;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchFirebaseData();
//   }
//    fetchFirebaseData()async{
//  querysnap =   await FirebaseFirestore.instance.collection("posts")
//     .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid )
//     .get();

//     if(querysnap.docs.isNotEmpty){

//       Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileCard()));
//     }

    


//    }
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  

  signUp() async {
    if (nameController.text == "" ||
        emailController.text == "" ||
        passwordController.text == "") {
      showDialogBox(context, true, "please fill all the fields");

      return;
//it wont move to try catch block at all
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showDialogBox(context, true, "Sign up successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
      //  Navigator.pop(context);
    } catch (e) {
      showDialogBox(context, true, e.toString());
    }

    setState(() {
      nameController.text = "";
      emailController.text = "";
      passwordController.text = "";
    });
  }
//initstate


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: myText("Sign up")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myIcon(Icons.person),
            myTextField(false, "User name", nameController),
            myTextField(false, "Email", emailController),
            myTextField(true, "Password", passwordController),
            myButton("Sign up", () {
              signUp();
            }),
            myTextButton("Already Sign up?", "Sign in now", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            }),
          ],
        ),
      ),
    );
  }
}
