import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }
}

class FirestoreSevice {
  final CollectionReference orders = 
    FirebaseFirestore.instance.collection('orders');

    Future<void> saveOderToDatabase(String receipt) async {
      await orders.add({
        'data' : DateTime.now(),
        'order' : receipt,
      });
    }

  
}