import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:prempranay/screens/profilecardwidget.dart';
import 'package:prempranay/screens/sign_up.dart';
import 'package:prempranay/util.dart';

//global access
String? currentUserName;
String? currentUserImageUrl;

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  QuerySnapshot? querySnapshot;
//track the like of each post/profiles
// Map<String, bool> likes = {};//empty map not null
  var currentUserPostId;

  // int currentIndex = 0; //in listview builder, index will automatically represnet the current
  //index but in cardswiper we have  update the current index

//fetch currentusername url etc
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCurrentUserData();
  }

  fetchCurrentUserData() async {
    querySnapshot = await FirebaseFirestore.instance
        .collection("posts")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (querySnapshot?.docs.isNotEmpty ?? false) {
      //explanation here if querysnapshot is null then whole expression is null then false will execute
      //mean function body won't run, if querysnapshot is not null then function body code will run

      var postId = querySnapshot
          ?.docs
          .first //it will retrieves the id of first document
          .id; //this is the postId of current user where every data is
      //stored
      currentUserPostId = postId;

      var documentsnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .get();
      currentUserName = documentsnapshot.get("name");
      currentUserImageUrl = documentsnapshot.get("imageUrl");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Swipe Card"),
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

      //when we press backbutton the initstate method wont call

      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .where("userId",
                  isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, asyncSnap) {
            if (asyncSnap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!asyncSnap.hasData || asyncSnap.data == null) {
              return Center(child: Text("No doc to fetch"));
            }

            final docs = asyncSnap.data!.docs;
            print('Documents length: ${docs.length}');
            if (asyncSnap.data!.docs.isEmpty) {
              return Center(child: Text("No card to fetch"));
            }

            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow,
                ),
                child: CardSwiper(
                  allowedSwipeDirection: AllowedSwipeDirection.only(left: true),

                  isLoop:
                      true, //so the card i swap initially wont return and we donot move on loop
                  onSwipe: (previusIndex, currentIndex, direction) {
                    var snap = asyncSnap.data!.docs[currentIndex!];
                    String postId = snap.get("postId");
                    String userId = snap.get("userId");
                    // current card index is 0 when i swipe right it will become 1
                    //if swipe card in right direction at first index will be 1 2 and so on,
                    //basically the left swipe is used to return previous card that we swipe
                    //previously like if i swipe right 2 times then index is from 1 and 2,
                    //now if i swip left then index will decrease to 1, second time i again
                    //left swipe the index decrease to 0, this is first position where we
                    //started from
                    if (direction == CardSwiperDirection.right) {
                      // like(snap, postId);
                      print("index is $currentIndex");
                    } else if (direction == CardSwiperDirection.left) {
                      // unlike(snap, postId);

                      print("index is $currentIndex");
                    }

                    //very important concept: the setstate is called insidw onSwipe means it does
                    //make infinetly running loop, the widget only rebuild when card will swipe
                    //otherwise don't

                    //   setState(() {
                    //   this.currentIndex = currentIndex!;//no need of this

                    // });

                    return true;
                  },

                  // cardsCount: 1,
                  //minium 2 card required if two doc  not available on firestore it will give
                  //error
                  cardsCount: asyncSnap.data!.docs.length,
                  cardBuilder: (context, index, x, y) {
                    var snap = asyncSnap.data!.docs[index]; //each profiles's
                    String postId = snap.get("postId");
                    String userId = snap.get("userId");
                    // bool liked = likes[postId] = false; it will assign false everytime- wrong
                    // bool isLiked = likes[postId]??false;//initially since map is empty likes[postId
                    //has no value or null value before updation in like and unlike method]
                    //initially since likes map is empty when we try to access likes[postid]'s value
                    //is null because there is no key called postId at the begining
                    //print more and more on console
                    // print(isLiked);
                     return ProfileCardWidget(
                      snap: snap,

                     );
                  },
                ),
              ),
            );
          }),
    );
  }
}
