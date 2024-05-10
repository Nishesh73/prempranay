// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDsuWzgyIkyOFkqfdD0C0yk2fUKhuqCqtA',
    appId: '1:659336804845:web:25ef881835db4b52920fe4',
    messagingSenderId: '659336804845',
    projectId: 'my-prem-pranay',
    authDomain: 'my-prem-pranay.firebaseapp.com',
    storageBucket: 'my-prem-pranay.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlul2hPov8KN2mDJHSOb58VdLnqkbiUMY',
    appId: '1:659336804845:android:09d1efd62d39190c920fe4',
    messagingSenderId: '659336804845',
    projectId: 'my-prem-pranay',
    storageBucket: 'my-prem-pranay.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_5NMdrglv-cl-k1s9DPiBDTm5uQWgIhQ',
    appId: '1:659336804845:ios:06cd65f02921931d920fe4',
    messagingSenderId: '659336804845',
    projectId: 'my-prem-pranay',
    storageBucket: 'my-prem-pranay.appspot.com',
    iosBundleId: 'com.example.prempranay',
  );
}
