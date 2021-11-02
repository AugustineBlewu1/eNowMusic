import 'package:e_now_music/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//   await FlutterDownloader.initialize(
//   debug: true // optional: set false to disable printing logs to console
// );
  runApp(MyApp());
}
