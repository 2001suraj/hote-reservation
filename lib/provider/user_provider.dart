import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userIndividualDataProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, documentId) async {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('user');
  DocumentReference documentReference = collectionReference.doc(documentId);

  try {
    DocumentSnapshot documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  } catch (e) {
    print('Error retrieving document: $e');
    return {};
  }
});
