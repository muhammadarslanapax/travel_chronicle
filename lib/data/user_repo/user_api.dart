// ignore_for_file: body_might_complete_normally_nullable, body_might_complete_normally_catch_error, depend_on_referenced_packages, empty_catches

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_chronicle/data/user_repo/user_repository.dart';

import '../model/user_model.dart';

class UserApi implements IUserRepository {
  final user = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference<UserModel> usersRef =
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  @override
  Future<UserModel?> get(String documentId) => usersRef.doc(documentId).get().then((s) => s.data());

  @override
  Future<void> add(UserModel user) => usersRef.doc(user.userId).set(user);

  @override
  Future<void> update(String documentId, Map<String, dynamic> map) async {
    await usersRef.doc(documentId).update(map);
  }

  @override
  Future<void> delete(String documentId) => usersRef.doc(documentId).delete();

  @override
  Future<void> login(String email, String password) async {
    EasyLoading.show(status: 'please wait...');
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      if (e.code == 'user-not-found') {
        EasyLoading.showError("No user found for that email.");
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        EasyLoading.showError("Wrong password provided for that user.");
        throw Exception('Wrong password provided for that user.');
      }
      if (e.message!.contains("INVALID_LOGIN_CREDENTIALS")) {
        EasyLoading.showError("Invalid Email or Password!");
      } else {
        EasyLoading.showError(e.toString());
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    EasyLoading.show(status: 'please wait...');
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'weak-password') {
        EasyLoading.showError("The password provided is too weak.");
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.showError("The account already exists for that email.");
        throw Exception('The account already exists for that email.');
      } else {
        EasyLoading.showError(e.toString());
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  @override
  Future<String> uploadFile(File image) async {
    Reference reference = FirebaseStorage.instance.ref().child('/${DateTime.now().millisecondsSinceEpoch.toString()}');
    await reference.putFile(image);
    return await reference.getDownloadURL();
  }

  @override
  Future<void> changePassword(String newPassword) async {
    EasyLoading.show(status: 'please wait...');
    try {
      await _firebaseAuth.currentUser!.updatePassword(newPassword);

      EasyLoading.dismiss();
      EasyLoading.showSuccess("successfully password updated!");
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'weak-password') {
        EasyLoading.showError("The password provided is too weak.");
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.showError("The account already exists for that email.");
        throw Exception('The account already exists for that email.');
      } else {
        EasyLoading.showError(e.toString());
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      throw Exception(e.toString());
    }
  }
}
