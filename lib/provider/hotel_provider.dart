import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hotelDataProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('hotel').snapshots();
});

final bookingDataProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('booking').snapshots();
});