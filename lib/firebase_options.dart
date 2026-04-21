// File generated based on google-services.json and GoogleService-Info.plist
// flutterfire configure equivalent

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALt6rnO6mlbjxX7K280A8sNSNoSk_1NDE',
    appId: '1:781456365983:android:bc0b0d7f6e4afe5d5405aa',
    messagingSenderId: '781456365983',
    projectId: 'quizapp-a4de4',
    storageBucket: 'quizapp-a4de4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnUkMp9LcG5HSunkeI-A1ihqHAvWv-Ij4',
    appId: '1:781456365983:ios:af38d06f02dec04f5405aa',
    messagingSenderId: '781456365983',
    projectId: 'quizapp-a4de4',
    storageBucket: 'quizapp-a4de4.firebasestorage.app',
    iosBundleId: 'com.berkayoz.quizapp',
    iosClientId: '781456365983-ebmfivcere3qk54b17gtp3rglcag31be.apps.googleusercontent.com',
  );
}
