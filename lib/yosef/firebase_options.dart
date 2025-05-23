// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyC8IFtZ_MjwHxyDZiDtxdBRMeb1CQ1Ay2U',
    appId: '1:741135549855:web:0a7ad2430d21e0d8b7a9aa',
    messagingSenderId: '741135549855',
    projectId: 'mindpal-50007',
    authDomain: 'mindpal-50007.firebaseapp.com',
    storageBucket: 'mindpal-50007.firebasestorage.app',
    measurementId: 'G-XDPW77Y7MM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtiog2npXsG3V4Uh-mS2MxxHe_wEw1VPk',
    appId: '1:741135549855:android:a51438d05fd44ea4b7a9aa',
    messagingSenderId: '741135549855',
    projectId: 'mindpal-50007',
    storageBucket: 'mindpal-50007.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7uHMc9Dz0vPMqM3giBKY4GxCe6Hxz2lM',
    appId: '1:741135549855:ios:3b42444c651da749b7a9aa',
    messagingSenderId: '741135549855',
    projectId: 'mindpal-50007',
    storageBucket: 'mindpal-50007.firebasestorage.app',
    iosBundleId: 'com.example.mindpal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7uHMc9Dz0vPMqM3giBKY4GxCe6Hxz2lM',
    appId: '1:741135549855:ios:3b42444c651da749b7a9aa',
    messagingSenderId: '741135549855',
    projectId: 'mindpal-50007',
    storageBucket: 'mindpal-50007.firebasestorage.app',
    iosBundleId: 'com.example.mindpal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC8IFtZ_MjwHxyDZiDtxdBRMeb1CQ1Ay2U',
    appId: '1:741135549855:web:4e2ed3182edeaa8cb7a9aa',
    messagingSenderId: '741135549855',
    projectId: 'mindpal-50007',
    authDomain: 'mindpal-50007.firebaseapp.com',
    storageBucket: 'mindpal-50007.firebasestorage.app',
    measurementId: 'G-FJSEFTEJBT',
  );
}
