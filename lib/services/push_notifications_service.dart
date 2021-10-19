// SHA1: 31:EF:E4:A2:49:C5:C1:2F:7B:82:A5:B0:FE:54:47:22:F1:B3:41:0D

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    // print( 'onBackground Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.notification?.title ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print( 'onMessage Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.notification?.title ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print( 'onMessageOpenApp Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.notification?.title ?? 'No data');
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();

    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notifications
  }

  static closeStream() {
    _messageStream.close();
  }
}
