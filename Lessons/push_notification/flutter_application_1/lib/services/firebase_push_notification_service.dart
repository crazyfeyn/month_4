import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushNotificationService {
  static final _pushNotification = FirebaseMessaging.instance;

  static Future<void> init() async {
    //push notification yuborish
    final notificationSettings = await _pushNotification.requestPermission();

    //quirilmani TOKEN ni qilamiz
    //shu orqali quirilmaga xabarnoma yuborishni aniqlaymiz
    final token = await _pushNotification.getToken();
    print(token);

   // backgrounda xabar kelsa ishlaydi
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
    });


    // foregroundda xabar kelsa ishlaydi
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
