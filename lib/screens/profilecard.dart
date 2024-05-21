import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:prempranay/screens/profilecardwidget.dart';
import 'package:prempranay/screens/sign_up.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  // int currentIndex = 0; //in listview builder, index will automatically represnet the current
  //index but in cardswiper we have  update the current index

   like(var snap, String postId)async{
    if(!snap.get("like").contains(FirebaseAuth.instance.currentUser?.uid)){
     await FirebaseFirestore.instance.collection("posts").doc(postId).update({
        "like": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])


      });

    }
}
unlike(snap, String postId)async{
    if(snap.get("like").contains(FirebaseAuth.instance.currentUser?.uid)){
      await FirebaseFirestore.instance.collection("posts").doc(postId).update({
         "like": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])



      });


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
              // .where("userId", isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)

              .snapshots(),
          builder: (context, asyncSnap) {

            if (asyncSnap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!asyncSnap.hasData ||
                asyncSnap.data == null 
              ) {
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
                child: CardSwiper(
                  allowedSwipeDirection:
                      AllowedSwipeDirection.only(right: true, left: true),

                  isLoop:
                      true, //so the card i swap initially wont return and we donot move on loop
                  onSwipe: (previusIndex, currentIndex, direction) {
 
           
                    var snap = asyncSnap.data!.docs[currentIndex!];
                    String postId = snap.get("postId");
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
                      
                      
                    }
               else if (direction == CardSwiperDirection.left) {
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
                    var snap = asyncSnap.data!.docs[index];
                    String postId = snap.get("postId");

                    return ProfileCardWidget(
                      snap: snap,
                      like: () {

                        like(snap, postId);//function call
                        
                      },
                      unlike: (){
                        unlike(snap, postId);//function call
                      },
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
