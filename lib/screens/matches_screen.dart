import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Matches extends StatelessWidget {
  var matchId;
  Matches({super.key, required this.matchId});

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matches"),
      ),
      body: Column(
        children: [
          Text(
            "Your likes",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Flexible(
            flex: 1,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("match")
                    .doc(matchId)
                    .snapshots(),
                builder: (context, asyncsnap) {
                  if (asyncsnap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!asyncsnap.hasData || !asyncsnap.data!.exists) {
                    return Center(child: Text("No match"));
                  }
                       var data = asyncsnap.data!.data() as Map<String, dynamic>;
                print('Data from Firestore: $data');
                  // asyncsnap.data!.exists//check document exist or not
                  //asyncsnap.hasData--check whether streambuilder receive
                  //data or not, via stream
                  //    if (asyncsnap.data == null) {

                  //   return Center(child: Text("No data fetch from stream"),);
                  // }

                  return ListView.builder(
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(asyncsnap.data
                                        ?.get("currentUserImageUrl"))),
                                Text("likes"),
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
          Text(
            "Your Chats",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Flexible(
            flex: 3,
            child: ListView.builder(
                // shrinkWrap: true,--means Listview takes the space as needed by its
                //content if the conent is large compare to available space cause an error
                //to resolve this problem, we use flexible or expanded as it will take
                //avaialble space
                scrollDirection: Axis.vertical,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      height: 210,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "images/couple.jpg",
                            ),
                          ),
                          Text("chats"),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
