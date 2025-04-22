import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions can provie service to the specific platform: $defaultTargetPlatform',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBon3lS4NCyFLqeTRPT30vmLTXQuFc_LUE',
    appId: '1:793503754752:web:604c4e1518da2d460a86e5',
    messagingSenderId: '793503754752',
    projectId: 'info-6350-55cba',
    authDomain: 'info-6350-55cba.firebaseapp.com',
    storageBucket: 'info-6350-55cba.firebasestorage.app',
    measurementId: 'G-6KVLPYPY7B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmlGmRS6EGyOTmkjvxd_hOKv-okUvvBp4',
    appId: '1:793503754752:android:0c36c5950c8da0840a86e5',
    messagingSenderId: '793503754752',
    projectId: 'info-6350-55cba',
    storageBucket: 'info-6350-55cba.firebasestorage.app',
  );

}