import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../storage/auth_client.dart';

class PushNotificationHelper{
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStreamController = StreamController.broadcast();
  static final AuthClient authClient = AuthClient();
  static Stream<String> get messagesStream => _messageStreamController.stream;

  static Future<void> storeNewToken(RemoteMessage message) async {
    if (message.data['token'] != null) {
      await authClient.updateToken(message.data['token']);
    }
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async{
    await storeNewToken(message);
    _messageStreamController.add(message.notification?.title ?? 'Sin título');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async{
    await storeNewToken(message);
    _messageStreamController.add(message.notification?.title ?? 'Sin título');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async{
    await storeNewToken(message);
    _messageStreamController.add(message.notification?.title ?? 'Sin título');
  }

  static Future<void> initializeApp() async{
    // Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    debugPrint("Token $token");

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static void closeStream() => _messageStreamController.close();
}