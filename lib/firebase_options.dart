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
    apiKey: 'AIzaSyDDsOkrfE3cAogBqMT0unq0iIK66MuARvo',
    appId: '1:562096085523:web:66d84367c53e64effcfde6',
    messagingSenderId: '562096085523',
    projectId: 'wisycamera',
    authDomain: 'wisycamera.firebaseapp.com',
    storageBucket: 'wisycamera.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB57XQSA1cpdnrGe94qwnlSIbqxcmmZCiQ',
    appId: '1:562096085523:android:c1344f299f996d8bfcfde6',
    messagingSenderId: '562096085523',
    projectId: 'wisycamera',
    storageBucket: 'wisycamera.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOBrJ1JGgBEgUDqQsWmJZ-GVTtfC86jOg',
    appId: '1:562096085523:ios:a31e6852c5458294fcfde6',
    messagingSenderId: '562096085523',
    projectId: 'wisycamera',
    storageBucket: 'wisycamera.appspot.com',
    iosBundleId: 'com.example.wisyCamera',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOBrJ1JGgBEgUDqQsWmJZ-GVTtfC86jOg',
    appId: '1:562096085523:ios:a31e6852c5458294fcfde6',
    messagingSenderId: '562096085523',
    projectId: 'wisycamera',
    storageBucket: 'wisycamera.appspot.com',
    iosBundleId: 'com.example.wisyCamera',
  );
}
