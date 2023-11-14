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
        return macos;
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
    apiKey: 'AIzaSyCPhbh4OXTHzjYsP2odKudiVcsmXqmnEl0',
    appId: '1:695899982339:web:149c8b556d6604a5455c36',
    messagingSenderId: '695899982339',
    projectId: 'fallapp-b4b00',
    authDomain: 'fallapp-b4b00.firebaseapp.com',
    storageBucket: 'fallapp-b4b00.appspot.com',
    measurementId: 'G-FPJBC9F41R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIvTtEu8uVgU2ONB5HSOkgKeCPi-5A8NU',
    appId: '1:695899982339:android:4f1dc0fcd1194562455c36',
    messagingSenderId: '695899982339',
    projectId: 'fallapp-b4b00',
    storageBucket: 'fallapp-b4b00.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTd4lfQN6YiWErOY9x8o7yUeTO4Z7GC94',
    appId: '1:695899982339:ios:7eb3aa215cc0d1af455c36',
    messagingSenderId: '695899982339',
    projectId: 'fallapp-b4b00',
    storageBucket: 'fallapp-b4b00.appspot.com',
    iosClientId: '695899982339-vead0ht17srmc7jdq36e8os4ciftcm8s.apps.googleusercontent.com',
    iosBundleId: 'com.example.fallAppGuncel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDTd4lfQN6YiWErOY9x8o7yUeTO4Z7GC94',
    appId: '1:695899982339:ios:e4d0915b6fcb8e53455c36',
    messagingSenderId: '695899982339',
    projectId: 'fallapp-b4b00',
    storageBucket: 'fallapp-b4b00.appspot.com',
    iosClientId: '695899982339-j77rro8r1jo43d4la7dsc8a3lhrpnpst.apps.googleusercontent.com',
    iosBundleId: 'com.example.fallAppGuncel.RunnerTests',
  );
}
