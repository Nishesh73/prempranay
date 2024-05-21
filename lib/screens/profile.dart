import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prempranay/screens/profilecard.dart';
import 'package:prempranay/screens/profiledetail.dart';
import 'package:prempranay/screens/sign_up.dart';
import 'package:prempranay/util.dart';
import 'package:uuid/uuid.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  File? file;
  bool lineaProgress = false;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  //do something motivation-- do not think about coding logic whatever you know just
  //write on editor then think about logic, one step at a time

  //if we donot need any parameter when calling function, the function() and function
  //pretty much the same

  ImagePicker imagePicker = ImagePicker();

  pickImageFromCamera() async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (xFile == null) {
      return;
    } else {
      setState(() {
        file = File(xFile!
            .path); //convert xFile object to File object and path gives the
        //information of path of picked file
      });
      print("photo clicked");
    }
    Navigator.of(context).pop();
  }

  pickImageFromGallery() async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xFile == null) {
      return; //if ongoing gallery, return user without selecting image
    } else {
      setState(() {
        file = File(xFile!
            .path); //convert xFile object to File object and path gives the
        //information of path of picked file
      });
      print("photo clicked");
    }
    Navigator.of(context).pop();
  }

//post to firestore
  postToFireBase() async {
    setState(() {
      lineaProgress = true;
    });

    if (file == null ||
        nameController.text == "" ||
        ageController.text == "" ||
        bioController.text == "" ||
        locationController.text == "" ||
        genderController.text == "" ||
        interestController.text == "") {
      showDialogBox(
          context, true, "fill every field and select the profile pic");

      setState(() {
        lineaProgress = false;
      });
      return;
    }

    //storing into cloud firestore

    print("code not reach here");

    try {
      FirebaseStorage storage = FirebaseStorage.instance;

      //random postId to store postimage
      var uuid = Uuid();
      String postId = uuid.v4();

      //refereence for location
      Reference reference = storage.ref().child("imageFolder").child(postId);
      //uploading
      await reference.putFile(file!);
      //downloading file
      String imageUrl = await reference.getDownloadURL();
      print("image url is $imageUrl");
      //storing data to cloud firestore

      await FirebaseFirestore.instance.collection("posts").doc(postId).set({
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "postId": postId,
        "time": DateTime.now(),
        "imageUrl": imageUrl,
        "name": nameController.text,
        "age": ageController.text,
        "bio": bioController.text,
        "location": locationController.text,
        "gender": genderController.text,
        "interest": interestController.text,
        "like": []

      });
      setState(() {
        lineaProgress = false;
        file = null;
        nameController.text = "";
        ageController.text = "";
        bioController.text = "";
        locationController.text = "";
        genderController.text = "";
        interestController.text = "";
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileCard()));
    } catch (e) {
      print("error is $e");

      setState(() {
        lineaProgress = false;
      });
      showDialogBox(context, true, "error occur ${e.toString()}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //direct directly if form is already filled
    fetchProfileDoc();
  }

  fetchProfileDoc() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

          // querySnapshot.docs != null is redundant and always true., because querySnapshot.docs
          //is List, very important concept
          //what we have to check is doc empty or not

      if (querySnapshot.docs.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileCard()));
      }
    } catch (e) {
      showDialogBox(context, true, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              lineaProgress ? LinearProgressIndicator() : Text(""),
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: file != null
                      ? CircleAvatar(
                          radius: 45,
                          // child:file!=null?Image.file(file!): AssetImage("images/couplerom.jpg"),
                          backgroundImage: FileImage(file!))
                      : CircleAvatar(
                          radius: 45,
                          // child:file!=null?Image.file(file!): AssetImage("images/couplerom.jpg"),
                          backgroundImage: AssetImage("images/couplerom.jpg"),
                        ),
                ),
                Positioned(
                    bottom: .1,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          showDialogBoxGalCamOpt(
                              context, "Chhose from following", () {
                            pickImageFromCamera();
                          }, () {
                            pickImageFromGallery();
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.black,
                        )))
              ]),
              Text("Log in as $userEmail"??"No email available",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              myTextField(false, "User name", nameController),
              myTextField(false, "age", ageController),
              myTextField(false, "bio", bioController),
              myTextField(false, "location", locationController),
              myTextField(false, "gender", genderController),
              myTextField(false, "interest", interestController),
              myButton("Submit", () {
                postToFireBase();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
