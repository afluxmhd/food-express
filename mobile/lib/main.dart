import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_express/controller/notification_controller.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:food_express/helper/dependencies.dart' as dep;
import 'package:food_express/helper/firebase.dart' as firebase;
import 'package:get/get.dart';

import 'model/notification_model.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await dep.init();
  Get.find<NotificationController>().getNotificationData();
  NotificationModel notification = NotificationModel(
      title: message.notification!.title!, message: message.notification!.body!, time: DateTime.now().toString());
  Get.find<NotificationController>().addNotification(notification);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await dep.init();
  await firebase.FirebaseHelper().initializeFirebase();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(Get.find<NotificationController>().firebaseMessagingForegroundhandler());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Express',
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
