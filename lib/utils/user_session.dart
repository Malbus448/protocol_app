import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSession {
  UserSession._();
  static final UserSession instance = UserSession._();

  Map<String, dynamic>? _userData;
  Future<Map<String, dynamic>?>? _inFlight;

  Future<Map<String, dynamic>?> loadCurrentUser() {
    final cached = _userData;
    if (cached != null) return Future.value(cached);

    final current = FirebaseAuth.instance.currentUser;
    if (current == null) return Future.value(null);

    _inFlight ??= FirebaseFirestore.instance
        .collection('users')
        .doc(current.uid)
        .get()
        .then((doc) {
      _inFlight = null;
      _userData = doc.data();
      return _userData;
    }).catchError((_) {
      _inFlight = null;
      return null;
    });

    return _inFlight!;
  }

  String? get role => _userData?['role']?.toString().toLowerCase();
  String? get team => _userData?['Teaam']?.toString();

  void clear() {
    _userData = null;
    _inFlight = null;
  }
}
