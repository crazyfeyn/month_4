import 'package:flutter/material.dart';
import 'package:flutter_application/services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await LocationService.getCurrentLocation();
      setState(() {});
      watchMyLocation();
    });
  }

  void watchMyLocation() {
    LocationService.getLiveLocation().listen((location) {
      print("Live location: $location");
    });
  }

  @override
  Widget build(BuildContext context) {
    final myLocation = LocationService.currentLocation;

    print(myLocation);
    return Scaffold();
  }
}
