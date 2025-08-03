import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    const androidInitialize = AndroidInitializationSettings(
      'mipmap/ic_launcher',
    );
    const initializationsSettings = InitializationSettings(
      android: androidInitialize,
    );

    await _notifications.initialize(initializationsSettings);
  }

  static Future showNotification({
    int id = 0,
    String title = 'Başarılı Kayıt',
    String body = 'Kullanıcı başarıyla oluşturuldu.',
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'Varsayılan kanal açıklaması',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(id, title, body, notificationDetails);
  }
}
