import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// إعداد الإشعارات وتشغيل الاستماع
Future<void> setupFlutterNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onNotificationResponse,
  );

  // ✅ قناة المريض
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'medicine_channel',
    'Medicine Reminders',
    description: 'Reminders to take your medicine',
    importance: Importance.high,
  );

  // ✅ قناة الدكتور
  const AndroidNotificationChannel doctorChannel = AndroidNotificationChannel(
    'doctor_channel',
    'Doctor Alerts',
    description: 'Notifications for doctors',
    importance: Importance.high,
  );

  final androidPlugin =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  await androidPlugin?.createNotificationChannel(channel);
  await androidPlugin?.createNotificationChannel(doctorChannel);

  // ✅ استماع للإشعارات القادمة
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role') ?? 'patient';

    if (role == 'patient') {
      showInteractiveNotification(message);
    } else {
      print("📲 Doctor notification received — auto handled by system");
    }
  });
}

/// استجابة المستخدم للزر في الإشعار
void onNotificationResponse(NotificationResponse response) {
  final medicineId = response.payload;

  if (response.actionId == 'ACCEPT_ACTION') {
    print("✅ User accepted medicine: $medicineId");
    sendActionToServer(medicineId, "taken");
  } else if (response.actionId == 'SKIP_ACTION') {
    print("❌ User skipped medicine: $medicineId");
    sendActionToServer(medicineId, "skipped");
  } else {
    print("👆 User tapped notification only: $medicineId");
  }
}

/// إرسال التصرف للسيرفر
Future<void> sendActionToServer(String? medicineId, String action) async {
  if (medicineId == null) return;

  final url =
      Uri.parse('https://your-backend.com/api/medicine-action'); // ✅ عدّله

  try {
    final response = await http.post(
      url,
      body: {
        'medicineId': medicineId,
        'action': action, // taken or skipped
      },
    );

    if (response.statusCode == 200) {
      print("📡 Action '$action' sent for medicineId: $medicineId");
    } else {
      print("❌ Failed to send action: ${response.body}");
    }
  } catch (e) {
    print("🔥 Error sending action: $e");
  }
}

/// عرض الإشعار التفاعلي
void showInteractiveNotification(RemoteMessage message) async {
  final data = message.data;
  final medicineName = (data['medicineName'] ?? 'Medicine').toString();
  final time = (data['time'] ?? 'Unknown time').toString();
  final medicineId = (data['medicineId'] ?? '').toString();

  final prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('role') ?? 'patient';

  AndroidNotificationDetails androidDetails;

  if (role == 'doctor') {
    androidDetails = AndroidNotificationDetails(
      'doctor_channel',
      'Doctor Alerts',
      channelDescription: 'Notifications for doctors',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: const Color(0xFF2196F3),
    );
  } else {
    androidDetails = AndroidNotificationDetails(
      'medicine_channel',
      'Medicine Reminders',
      channelDescription: 'Reminders to take your medicine',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'ACCEPT_ACTION',
          '✅ Taken',
          showsUserInterface: true,
          cancelNotification: true,
        ),
        AndroidNotificationAction(
          'SKIP_ACTION',
          '❌ Skip',
          showsUserInterface: true,
          cancelNotification: true,
        ),
      ],
    );
  }

  final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  await flutterLocalNotificationsPlugin.show(
    notificationId,
    role == 'doctor' ? '👨‍⚕️ Doctor Alert' : '💊 Medicine Reminder',
    '$medicineName at $time',
    NotificationDetails(android: androidDetails),
    payload: medicineId,
  );
}

void showInteractiveNotification2(RemoteMessage message) async {
  final data = message.data;
  final medicineName = data['medicineName'] ?? 'Medicine';
  final time = data['time'] ?? 'Unknown time';
  final medicineId = data['medicineId'] ?? '';

  final prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('role');

  flutterLocalNotificationsPlugin.show(
    0,
    '💊 Medicine Reminder',
    '$medicineName at $time',
    NotificationDetails(
      android: AndroidNotificationDetails(
        'medicine_channel',
        'Medicine Reminders',
        channelDescription: 'Reminders to take your medicine',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            'ACCEPT_ACTION',
            '✅ Taken',
            showsUserInterface: true,
            cancelNotification: true,
          ),
          AndroidNotificationAction(
            'SKIP_ACTION',
            '❌ Skip',
            showsUserInterface: true,
            cancelNotification: true,
          ),
        ],
      ),
    ),
    payload: medicineId,
  );
}
