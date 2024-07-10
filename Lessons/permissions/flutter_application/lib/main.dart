import 'package:flutter/material.dart';
import 'package:flutter_application/services/location_service.dart';
import 'package:flutter_application/views/screens/home_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // final cameraPermission = await Permission.camera.status;
  // final locationPermission = await Permission.location.status;
  // if (cameraPermission != PermissionStatus.granted) {
  //   await Permission.camera.request();
  // }

  // if (locationPermission != PermissionStatus.granted) {
  //   await Permission.location.request();
  // }

  // Map<Permission, PermissionStatus> statuses = await [
  //   Permission.location,
  //   Permission.camera,
  // ].request();

  // print(statuses);

  await LocationService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
