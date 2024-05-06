import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotificationHelper{
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStreamController = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStreamController.stream;

  static Future<void> _backgroundHandler(RemoteMessage message) async{
    _messageStreamController.add(message.notification?.title ?? 'Sin título');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async{
    debugPrint("${message.data}");
    _messageStreamController.add(message.notification?.title ?? 'Sin título');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async{
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

  static void closeStream(){
    _messageStreamController.close();
  }
}