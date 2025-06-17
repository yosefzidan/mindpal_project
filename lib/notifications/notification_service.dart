import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

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

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'medicine_channel',
    'Medicine Reminders',
    description: 'Reminders to take your medicine',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen(showInteractiveNotification);
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

/// إرسال التصرف للباك
Future<void> sendActionToServer(String? medicineId, String action) async {
  if (medicineId == null) return;

  final url = Uri.parse(
      'https://your-backend.com/api/medicine-action'); // 🛠️ عدّل الرابط حسب API الباك

  try {
    final response = await http.post(
      url,
      body: {
        'medicineId': medicineId,
        'action': action, // "taken" or "skipped"
      },
    );

    if (response.statusCode == 200) {
      print(
          "📡 Action '$action' sent successfully for medicineId: $medicineId");
    } else {
      print("❌ Failed to send action to backend: ${response.body}");
    }
  } catch (e) {
    print("🔥 Error sending action: $e");
  }
}

/// عرض الإشعار بالأزرار
void showInteractiveNotification(RemoteMessage message) {
  final data = message.data;
  final medicineName = data['medicineName'] ?? 'Medicine';
  final time = data['time'] ?? 'Unknown time';
  final medicineId = data['medicineId'] ?? '';

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
