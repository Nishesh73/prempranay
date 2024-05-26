import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prempranay/screens/sign_up.dart';
import 'package:prempranay/util.dart';

class ProfileDetail extends StatefulWidget {
  var snap;

  ProfileDetail({super.key, required this.snap});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUp()));
    } catch (e) {
      showDialogBox(context, true, "logout error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                logOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: Stack(children: [
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: Image.network(
                  widget.snap.get(
                    "imageUrl",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 50,
                left: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.snap.get("name"),
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        Text(", ${widget.snap.get("age")}",
                            style: TextStyle(
                              fontSize: 25.0,
                            )),
                      ],
                    ),
                    Text(widget.snap.get("location")),
                    Text(widget.snap.get("interest")),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
