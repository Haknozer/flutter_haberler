import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkFirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void fir() {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    users.add({"add": "da"});
  }
}
