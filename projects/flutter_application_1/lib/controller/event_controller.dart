import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/event_model.dart';
import 'package:flutter_application_1/services/firebase_event_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventController extends ChangeNotifier {
  final firebaseEventServices = FirebaseEventServices();

  Future<void> addEvent(
      String eventTitle,
      Timestamp eventDateTime,
      String eventDescription,
      LatLng? currentLocation,
      File? imageFile,
      String userId,
      String locationName) async {
    return firebaseEventServices.addEvent(eventTitle, eventDateTime,
        eventDescription, currentLocation, imageFile, userId, locationName);
  }

  Stream<QuerySnapshot> fetchEventStream() {
    return firebaseEventServices.fetchEventStream();
  }

  Stream<QuerySnapshot> fetchMyEventStream(String userId) {
    return firebaseEventServices.fetchMyEventStream(userId);
  }

  Future<void> deleteEvent(String eventId) async {
    return firebaseEventServices.deleteEvent(eventId);
  }

  Future<void> editEvent(
      String eventId,
      String eventTitle,
      Timestamp eventDateTime,
      String eventDescription,
      LatLng? currentLocation,
      File? imageFile,
      String locationName) async {
    return firebaseEventServices.editEvent(eventId, eventTitle, eventDateTime,
        eventDescription, currentLocation, imageFile, locationName);
  }

  Future<void> likeEvent(String eventId, String userId) async {
    return firebaseEventServices.likeEvent(eventId, userId);
  }

  Future<void> unlikeEvent(String eventId, String userId) async {
    return firebaseEventServices.unlikeEvent(eventId, userId);
  }

  Stream<QuerySnapshot> getRecentSevenDaysEvents() {
    return firebaseEventServices.getRecentSevenDaysEvents();
  }

  void toggleLike(EventModel event, BuildContext context)  {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final isLiked = event.likedUsers.contains(userId);

    if (isLiked) {
      unlikeEvent(event.eventId, userId);
    } else {
      likeEvent(event.eventId, userId);
    }

    if (isLiked) {
      event.likedUsers.remove(userId);
    } else {
      event.likedUsers.add(userId);
    }

    notifyListeners();
  }
}
