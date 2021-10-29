import 'dart:convert';

import 'package:e_now_music/src/services/firebaseDocument.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_logger/simple_logger.dart';

class FirebaseAuthentication extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? _userIdtoken;
  String? _uid;
  final logger = SimpleLogger();
  bool _fetching = false;

  String? get userId => _userIdtoken;
  String? get uid => _uid;
  bool get fetching => _fetching;

  Future<User?> signUpwithEmailandPassword({name, email, password}) async {
    return authenticateUser(
        email: email, password: password, authType: 'signUp', name: name);
  }

  Future<User?> login({email, password}) async {
    return authenticateUser(
        email: email, password: password, authType: 'login');
  }

  Future<User?> authenticateUser(
      {String? email, String? password, String? authType, String? name}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final user = authType == 'signUp'
          ? await auth.createUserWithEmailAndPassword(
              email: email!, password: password!)
          : await auth.signInWithEmailAndPassword(
              email: email!, password: password!);

      if (user.user != null) {
        _userIdtoken = await user.user!.getIdToken();
        _uid = await user.user!.uid;
        final userData = {'token': _userIdtoken, 'uid': _uid};
        preferences.setString('userData', json.encode(userData));

        authType == 'signUp'
            ? Document().addUser(userEmail: email, userName: name)
            : null;
        notifyListeners();
      } else {
        logger.info(user);
        throw Exception(user);
      }
    } catch (e) {
      logger.warning(e);
      throw Exception(e);
    }
    
  }
}
