import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBf-lvz7K092LMQy-2EmrUMXxBg8KzgIjw",
            authDomain: "eventfull-7b3e6.firebaseapp.com",
            projectId: "eventfull-7b3e6",
            storageBucket: "eventfull-7b3e6.appspot.com",
            messagingSenderId: "429711773743",
            appId: "1:429711773743:web:19b2a50022f9f73f6976da"));
  } else {
    await Firebase.initializeApp();
  }
}
