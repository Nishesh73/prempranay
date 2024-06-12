import 'package:flutter/material.dart';
class LikeButton extends StatelessWidget {
  const LikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("hello");
      },
      child: Icon(
        Icons.favorite
        
      
      ),
    );
  }
}