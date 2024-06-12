import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prempranay/screens/button.dart';
class ProfileCardWidget extends StatelessWidget {
  final snap;
  const ProfileCardWidget({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Expanded(child: Image.network(snap.get("imageUrl"))),
        Text(snap.get("name")),
        LikeButton(),

      ],
    );
  }
}