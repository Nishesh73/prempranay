import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prempranay/screens/profiledetail.dart';
class ProfileCardWidget extends StatefulWidget {
  var snap;
  VoidCallback like;
  VoidCallback unlike;
  ProfileCardWidget({super.key, required this.snap, required this.like, required this.unlike});

  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {

  


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: MediaQuery.of(context).size.height* .9,
        width: MediaQuery.of(context).size.width* .9,
        
        color: Colors.black,
        child: Column(children: [
        
          // Text(snap.get("name")),
          Flexible(
          
            child: Stack(
              children:[ SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height* .8, 
                child: Image.network(widget.snap.get("imageUrl", ),
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
                      Text(widget.snap.get("name"), style: TextStyle(fontSize: 25.0, fontWeight:FontWeight.bold),),
                      Text(", ${widget.snap.get("age")}", style: TextStyle(fontSize: 25.0,)),
                    ],
                  ),
                
                  Text(widget.snap.get("location")),
                
                ],),
              )
        ]
            ),
          ),
              
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
           //important note 
        //  When you write ElevatedButton(onPressed: widget.like)-means we pass the like as
        //reference of function, but ElevatedButton(onPressed: () { widget.like(); })--here 
        //we creat annonymous function which will run like()function when user press button
        //both are valid little bit aware on syntax thats it
            IconButton(onPressed:  widget.unlike
            , icon: Icon(Icons.thumb_down,
            color: Colors.red,
            )),
             IconButton(onPressed: widget.like

             , icon: Icon(Icons.thumb_up,
             color: Colors.green,
             
             ))
          ],),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDetail(snap: widget.snap)));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.white,
        minWidth: double.maxFinite,
        height: 50,
        child: Text("View Profile"),
        
        ),
      )
        
        ],
        
        
        ),
      ),
    );
  }
}