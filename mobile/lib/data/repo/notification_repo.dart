import 'dart:convert';

import 'package:food_express/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/notification_model.dart';

class NotificationRepo {
  final SharedPreferences sharedPreferences;
  NotificationRepo({required this.sharedPreferences});

  List<String> notifications = [];

  void addToNotificationList(List<NotificationModel> notificationList) {
    notifications = [];
    notifications = notificationList.map((notification) {
      return json.encode(notification.toMap());
    }).toList();
    print(" DATA Added to SharedPref\n  :${notifications}");
    sharedPreferences.setStringList(AppConstants.NOTIFICATION, notifications);
    getNotificationList();
  }

  List<NotificationModel> getNotificationList() {
    List<String> notifications = [];

    if (sharedPreferences.containsKey(AppConstants.NOTIFICATION)) {
      notifications = sharedPreferences.getStringList(AppConstants.NOTIFICATION)!;
      print('Notification fetched');
    }

    List<NotificationModel> notificationList = [];

    notificationList = notifications.map((notification) {
      Map<String, dynamic> map = json.decode(notification);
      return NotificationModel.fromMap(map);
    }).toList();

    return notificationList;
  }
}
