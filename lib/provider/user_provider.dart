import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:salon_appointment_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel currentUser = UserModel();

  Future<bool> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(uid)
          .get();
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        currentUser = UserModel(
          uid: data['uid'] ?? '',
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          phoneNo: data['phone'] ?? '',
        );
        notifyListeners();
        notifyListeners();
      }
      return true;
    } catch (e) {
      debugPrint('Login Error: $e');
      return false;
    }
  }

  Future<bool> signupUser(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      // store in user model first
      String uid = userCredential.user!.uid;
      currentUser = UserModel(
        uid: uid,
        name: name.trim(),
        email: email.trim(),
        phoneNo: phone.trim(),
      );
      // store in firestore
      await _firestore.collection('users').doc(uid).set({
        'uid': currentUser.uid,
        'name': currentUser.name,
        'email': currentUser.email,
        'phone': currentUser.phoneNo,
        'createdAt': FieldValue.serverTimestamp(),
      });
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Signup Error: $e');
      return false;
    }
  }
}
