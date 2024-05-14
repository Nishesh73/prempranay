import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:prempranay/screens/profilecardwidget.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("posts")
          .where("userId", isNotEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
          builder: (context, asyncSnap) {
            if (asyncSnap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!asyncSnap.hasData ||
                asyncSnap.data == null ||
                asyncSnap.data?.docs == null) {
              return Center(child: Text("No doc to fetch"));
            }

            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CardSwiper(
                  allowedSwipeDirection:
                      AllowedSwipeDirection.only(right: true, left: true),

                  isLoop:
                      true, //so the card i swap initially wont return and we donot move on loop
                  onSwipe: (previus, current, direction) {
                    if (direction == CardSwiperDirection.right) {
                      print("Right swipe");
                    }
                    if (direction == CardSwiperDirection.left) {
                      print("left swipe");
                    }

                    return true;
                  },

                  // cardsCount: 1,

                  cardsCount: asyncSnap.data!.docs.length,
                  cardBuilder: (context, index, x, y) {
                    var snap = asyncSnap.data!.docs[index];

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
