import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hotel_reservation_app/core/model/hotel_model.dart';

class HotelFirebase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> add(HotelModel model) async {
    await firebaseFirestore.collection('hotel').doc(model.name).set(
      {
        "name": model.name,
        "image": '',
        "address": model.location,
        "person": '1',
        "rating": model.rating,
        "price": model.price,
        "description": model.description,
        "photo": [],
      },
    );
  }

  Future<void> book(HotelModel model) async {
    await firebaseFirestore.collection('booking').doc().set(
      {
        "name": model.name,
        "image": model.image,
        "address": model.location,
        "person": model.person,
        "rating": model.rating,
        "price": model.price,
        "description": model.description,
        "status": model.status,
        "checkin": model.checkin,
        "checkout": model.checkout,
        "photo": model.photo,
      },
    );
  }

  Future<void> update(HotelModel model, String id) async {
    await firebaseFirestore.collection('booking').doc(id).update(
      {
        "name": model.name,
        "image": model.image,
        "address": model.location,
        "person": model.person,
        "rating": model.rating,
        "price": model.price,
        "description": model.description,
        "status": model.status,
        "checkin": model.checkin,
        "checkout": model.checkout,
        "photo": model.photo,
      },
    );
  }

  Future<void> delete( String id) async {
    await firebaseFirestore.collection('booking').doc(id).delete();
  }
}
