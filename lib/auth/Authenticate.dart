import 'dart:io';

import 'package:WorkzApp_flutter/model/user.dart';
import 'package:WorkzApp_flutter/utils/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class FireStoreUtils {
  static Firestore firestore = Firestore.instance;
  static DocumentReference currentUserDocRef =
      firestore.collection("USERS").document(MyHomePage.currentUser.userID);
  StorageReference storage = FirebaseStorage.instance.ref();
  
  Future<User> getCurrentUser(String uid) async {
    DocumentSnapshot userDocument =
        await firestore.collection("USERS").document(uid).get();
    if (userDocument != null && userDocument.exists) {
      return User.fromJson(userDocument.data);
    } else {
      return null;
    }
  }

  Future<User> updateCurrentUser(User user, BuildContext context) async {
    return await firestore
        .collection("USERS")
        .document(user.userID)
        .setData(user.toJson())
        .then((document) {
      return user;
    }, onError: (e) {
      print(e);
      showAlertDialog(context, 'Error', 'Failed to Update, Please try again.');
      return null;
    });
  }

  Future<String> uploadUserImageToFireStorage(File image, String userID) async {
    StorageReference upload = storage.child("images/$userID.png");
    StorageUploadTask uploadTask = upload.putFile(image);
    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadUrl.toString();
  }
}
