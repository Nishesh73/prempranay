import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prempranay/firebase_options.dart';
import 'package:prempranay/screens/matches_screen.dart';
import 'package:prempranay/screens/profile.dart';
import 'package:prempranay/screens/profilecard.dart';
import 'package:prempranay/screens/sign_up.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //ensure flutter framework initialized properly

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  //flutter run -d edge --web-renderer html
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PremPranay',
        // home: ProfileCard(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, asyncsnap) {
              if (asyncsnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (asyncsnap.hasData) {
                // return Matches();

                return Profile();
                // return ProfileCard();
              }

              return SignUp();
            }));
  }
}
