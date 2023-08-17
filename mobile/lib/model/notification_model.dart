class NotificationModel {
  String title;
  String message;
  String time;
  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'time': time,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      message: map['message'] as String,
      time: map['time'] as String,
    );
  }
}
