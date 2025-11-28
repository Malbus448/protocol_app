import 'package:cloud_firestore/cloud_firestore.dart';

class DataCache {
  DataCache._();

  static final Map<String, List<QueryDocumentSnapshot>> _collections = {};
  static List<QueryDocumentSnapshot>? _contacts;

  static Future<List<QueryDocumentSnapshot>> getCollectionOrderedByName(
    String collection,
  ) async {
    final cached = _collections[collection];
    if (cached != null) return cached;

    final snap = await FirebaseFirestore.instance
        .collection(collection)
        .orderBy('Name')
        .get();
    _collections[collection] = snap.docs;
    return snap.docs;
  }

  static Future<List<QueryDocumentSnapshot>> getContacts() async {
    if (_contacts != null) return _contacts!;
    final snap =
        await FirebaseFirestore.instance.collection('users').orderBy('Name').get();
    _contacts = snap.docs;
    return _contacts!;
  }

  static void clear() {
    _collections.clear();
    _contacts = null;
  }
}
