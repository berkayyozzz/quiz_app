import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  /// Oturum boyunca yalnızca bir kez izin sorulmasını sağlayan bayrak
  static bool _permissionsAlreadyRequested = false;

  NotificationService._internal();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestAlertPermission: false, // We will request explicitly
            requestBadgePermission: false,
            requestSoundPermission: false);

    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
      },
    );

    // Setup FCM
    await _setupFCMListeners();
  }

  Future<void> _setupFCMListeners() async {
    // When the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FCM Message received in foreground: ${message.notification?.title}");
      _showLocalNotification(message);
    });

    // When the app is in background but opened by tapping the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("FCM Message opened app: ${message.notification?.title}");
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null) {
      await flutterLocalNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'Genel Bildirimler',
            channelDescription: 'Bu kanal genel uygulama bildirmleri içindir.',
            importance: Importance.max,
            priority: Priority.high,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }

  Future<void> requestPermissions() async {
    // Daha önce sorulduysa bir daha sorma
    if (_permissionsAlreadyRequested) return;
    _permissionsAlreadyRequested = true;

    // Android
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationsPermission();
    await androidImplementation?.requestExactAlarmsPermission();

    // iOS
    final iOSImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    await iOSImplementation?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    // FCM Permissions
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('FCM Permission status: ${settings.authorizationStatus}');

    // Print FCM Token for testing
    await getFCMToken();
  }

  Future<String?> getFCMToken() async {
    try {
      String? token = await _fcm.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Error getting FCM Token: $e");
      return null;
    }
  }

  Future<void> scheduleStreakReminder(int currentStreak) async {
    // Cancel any existing streak alarms
    await flutterLocalNotificationsPlugin.cancel(id: 0); 

    // Prepare motivational messages
    final List<String> titles = [
      "Eyvah, serin bozuluyor! 🔥",
      "Hemen seriye başla! 💪",
      "Hedefinden vazgeçme! 🎯",
      "Bugün günlerden Quiz! 📚"
    ];

    final List<String> bodyMessages = [
      "Şu anki serin $currentStreak! Bugün hiç çalışmadın, serini bozmamak için hemen gel!",
      "Her gün çalış ve sınavı kazan! Rakiplerin çalışıyor, sen neredesin?",
      "$currentStreak günlük ateşin sönmek üzere! Lütfen ocağı harlamaya gel.",
      "Sadece 2 dakikanı alacak! Bir quiz çöz, zihnini zinde tut."
    ];

    final random = Random();
    final String selectedTitle = titles[random.nextInt(titles.length)];
    final String selectedBody = bodyMessages[random.nextInt(bodyMessages.length)];

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'streak_reminders', // id
      'Günlük Seri', // name
      channelDescription: 'Seriniz tehlikedeyken gelen hatırlatmalar.',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinPlatformChannelSpecifics);

    // Schedule for 22 hours from now!
    final scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(hours: 22));

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id: 0,
        title: selectedTitle,
        body: selectedBody,
        scheduledDate: scheduledDate,
        notificationDetails: platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      print('✅ Streak reminder scheduled for $scheduledDate');
    } catch (e) {
      print('❌ Failed to schedule streak reminder: $e');
    }
  }
}
