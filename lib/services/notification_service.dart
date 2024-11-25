import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();
  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('Permission status: ${settings.authorizationStatus}');
  }

  //init
  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermission();
    await _setupMessageHandlers();
    final token = await _messaging.getToken();
    print('fcm token$token');
  }

  //setup
  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }
    //android
    const channel = AndroidNotificationChannel(
        'high_importance_channel', 'High Importance Notifications',
        description: 'This channel is used for important notifications',
        importance: Importance.high);
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //ios
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    //flutter notification setup
    await _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {});
    _isFlutterLocalNotificationsInitialized = true;
  }

  //show notification
  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notifification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notifification != null && android != null) {
      await _localNotifications.show(
          notifification.hashCode,
          notifification.title,
          notifification.body,
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'hight_importance)channel', 'High Importance Notifications',
                  channelDescription:
                      'This channel is used for importance notifications',
                  importance: Importance.high,
                  priority: Priority.high,
                  icon: '@mipmap/ic_launcher'),
              iOS: DarwinNotificationDetails(
                  presentAlert: true, presentBadge: true, presentSound: true)),
          payload: message.data.toString());
    }
  }

  //listen to notification
  Future<void> _setupMessageHandlers() async {
    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });
    //background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    //opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      print(message.data['types']);
    }
  }
}
