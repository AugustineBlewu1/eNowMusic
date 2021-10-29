import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Document extends ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference musics = FirebaseFirestore.instance.collection('musics');

  Future<void> addUser({String? userEmail, String? userName}) {
    return users.add({
      'email': userEmail,
      'username': userName,
    }).then((value) {
      print(value);
    }).catchError((error) {
      print(error);
    });
  }
}
