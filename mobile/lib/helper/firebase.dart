import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../firebase_options.dart';

class FirebaseHelper {
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Firebase initialized!!');
  }

  Future<String> requestFCMPermissionAndPrintToken() async {
    await FirebaseMessaging.instance.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: false,
    );

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $fcmToken');
    return fcmToken ?? "food-express";
  }
}
