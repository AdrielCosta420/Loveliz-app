import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class UserRepository {
  Future<void> getUser();
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<void> getUser() async {
    final response = await _firestore.doc('users').get();
    response.get('name');
  }
}
