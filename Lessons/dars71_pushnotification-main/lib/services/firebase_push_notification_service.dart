import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class FirebasePushNotificationService {
  static final _pushNotification = FirebaseMessaging.instance;

  // Push Notification uchun ruxsat so'raymiz
  // va qurilmani TOKEN'ni aniqlab olamiz
  static Future<void> init() async {
    // ruxsat so'raymiz va natijatisini saqlaymiz
    final notificationSettings = await _pushNotification.requestPermission(
      provisional: true,
    );

    // ruxsat holati
    print(notificationSettings.authorizationStatus);

    // quirlma TOKEN'ni olamiz (shu orqali kimga xabar yuborishni bilamiz)
    final token = await _pushNotification.getToken();
    print(token);

    // Dasturda vaqti xabarni olish uchun
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('DASTURDA VAQTIMIZ KELDI');
      print('XABAR: ${message.data}');

      if (message.notification != null) {
        print('XABARDAGI ASOSIY MA\'LUMOT: ${message.notification!.title}');
      }
    });

    // Orqa fonda xabarni ustiga bosib dasturga kirgan vaqtda
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("ORQA FONDAN DASTURGA KIRIB KELDIM");
    });

    // Orqa fonda xabarni olish uchun
    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );

    await FirebaseMessaging.instance.subscribeToTopic("KunlikMotivatsiyalar");
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("ORQA FONDA XABAR KELDI: ${message.notification!.body}");
  }

  static Future<void> sendNotification() async {
    await Future.delayed(Duration(seconds: 5));

    final serviceAccount = await rootBundle.loadString("service-account.json");

    var accountCredentials = ServiceAccountCredentials.fromJson(serviceAccount);

    var scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    final client = await clientViaServiceAccount(accountCredentials, scopes);

    print(client.credentials.accessToken);

    final notificationData = {
      'message': {
        'token':
            'd-Q1uHBJQU2R3PIE5DbdLa:APA91bH5niH7fbu46_9NugtpSBhUmfyc9dR6SQwH1gmKVgNphBB9oEtXYLYDGeygG1AQbelQTDQDYtvJk8tr9gldNnyYXbLTV7UjfbR00Mi5gHU180CMYocOrpqiRnIYK4eNH14PjHD8',
        'notification': {
          'title': "Javohirdan Taklifnoma",
          'body': "Aka 30-Iyul, 2030 yil tuyim bo'lyapdi. Kelurasizlar endi!",
        }
      },
    };

    const projectId = "dars71-push-notification-0000";
    Uri url = Uri.parse(
      "https://fcm.googleapis.com/v1/projects/$projectId/messages:send",
    );

    final response = await client.post(
      url,
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${client.credentials.accessToken}',
      },
      body: jsonEncode(notificationData),
    );

    client.close();
    if (response.statusCode == 200) {
      print("YUBORILDI");
    } else {
      print(
          'Notification Sending Error Response status: ${response.statusCode}');
      print('Notification Response body: ${response.body}');
    }
  }
}
