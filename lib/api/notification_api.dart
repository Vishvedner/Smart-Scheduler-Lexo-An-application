import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../utils.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  var initializeAndroidSettings  = AndroidInitializationSettings('mipmap/ic_launcher');

  static Future _notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        icon: "launch_background",
      ),
      //iOS: IOSNotificationDetails(),
    );
  }
  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(
          id,
          title,
          body,
          await _notificationDetails(),
          payload: payload,
      );

  static void showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notification.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(),
        payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
}