import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // Web configuration from Firebase console
      return const FirebaseOptions(
        apiKey: 'AIzaSyB_ljaUxN5lrZK3Wq-E0ylb2_BF8vi8I1U',
        authDomain: 'smart-jothidam-4bc7f.firebaseapp.com',
        projectId: 'smart-jothidam-4bc7f',
        storageBucket: 'smart-jothidam-4bc7f.firebasestorage.app',
        messagingSenderId: '531056257',
        appId: '1:531056257:web:159c51dbc0e7345221ef80',
      );
    }

    // Fallback for non-web platforms (can be customized later)
    return const FirebaseOptions(
      apiKey: 'AIzaSyB_ljaUxN5lrZK3Wq-E0ylb2_BF8vi8I1U',
      projectId: 'smart-jothidam-4bc7f',
      storageBucket: 'smart-jothidam-4bc7f.firebasestorage.app',
      messagingSenderId: '531056257',
      appId: '1:531056257:web:159c51dbc0e7345221ef80',
    );
  }
}
