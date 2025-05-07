import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_project_1/user/models/model/create_request_model.dart';
import 'package:mini_project_1/user/models/model/user_register_auth_model.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
    required String mobile,
    required String profileUrl,
    required String location,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        UserRegisterAuthModel newUser = UserRegisterAuthModel(
            uid: user.uid,
            name: name,
            mobile: mobile,
            email: email,
            location: location,
            profileUrl: profileUrl);

        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
        return null;
      } else {
        return 'User registration failed';
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'An unknown error occurred';
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Login successful
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An unknown error occurred';
    } catch (e) {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}

class FirebaseFirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> submitMechanicRequest(UserCreateRequestModel request) async {
    try {
      await _firestore.collection('mechanic_requests').add({
        ...request.toMap(),
        'status': 'Requested',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to submit request: $e');
    }
  }

  Future<void> updateMechanicDetails({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String profileUrl,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('users').doc(uid).update({
      'name': name,
      'email': email,
      'mobile': phone,
      'location': location,
      'profileUrl': profileUrl,
    });
  }
}
