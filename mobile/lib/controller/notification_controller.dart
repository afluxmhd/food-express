// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_express/base/show_custom_snackbar.dart';
import 'package:get/get.dart';

import 'package:food_express/model/notification_model.dart';

import '../data/repo/notification_repo.dart';
import '../utils/colors.dart';

class NotificationController extends GetxController {
  NotificationController({required this.notificationRepo});

  final NotificationRepo notificationRepo;

  List<NotificationModel> _notificationList = [];
  List<NotificationModel> get notificationList => _notificationList;

  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;

  List<NotificationModel> storageNotification = [];

  dynamic firebaseMessagingForegroundhandler() {
    return (RemoteMessage message) async {
      print('Foreground:: ${message.notification!.title!}');

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      InitializationSettings initializationSettings = const InitializationSettings(android: initializationSettingsAndroid);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      if (message.notification != null) {
        NotificationModel notification = NotificationModel(
            title: message.notification!.title!, message: message.notification!.body!, time: DateTime.now().toString());
        addNotification(notification);
        _showLocalNotification(message.notification!.title, message.notification!.body, flutterLocalNotificationsPlugin);
      }
    };
  }

  void _showLocalNotification(
      String? title, String? body, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_priority_channel',
      'High Priority Channel',
      importance: Importance.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title, // Notification title
      body, // Notification body
      platformChannelSpecifics,
    );
  }

  void addNotification(NotificationModel notificationModel) async {
    _notificationList.add(notificationModel);
    addToNotificationList(); //to repo
    update();
  }

  //setter for Notification
  set _setNotification(List<NotificationModel> notifications) {
    storageNotification = notifications;

    for (int i = 0; i < storageNotification.length; i++) {
      notificationList.add(storageNotification[i]);
    }
  }

  set setNotification(List<NotificationModel> setItems) {
    _notificationList = [];
    _notificationList = setItems;
  }

  void addToNotificationList() {
    notificationRepo.addToNotificationList(notificationList);
    update();
  }

  List<NotificationModel> getNotificationData() {
    _setNotification = notificationRepo.getNotificationList();
    return storageNotification;
  }

  void changeNotificationAlert(bool value) {
    _isNotificationEnabled = value;
    Get.snackbar("Notification", value ? "Notifications have been turned on" : "Notifications have been turned off",
        backgroundColor: AppColors.mainColor, colorText: Colors.white);
    update();
  }

  void clearNotificationHistory() {
    if (_notificationList.isNotEmpty) {
      Get.snackbar("Notification Cleared", " Notifications history has been cleared",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    } else {
      showCustomSnackbar('Notification history not available', title: 'No Notification');
    }
    _notificationList = [];
    notificationRepo.clear();

    update();
  }
}
