import 'package:flutter/material.dart';

ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color(0XFFF32314A),
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));

Color eNowColor = Color(0XFFF32314A);

List<Map<String, dynamic>> musicData = [
  { "id": 23,"image": "mic.jpg", "title": "Sunday Morning", "subtitle": "Kwaku Awu"},
  { "id": 24, "image": "humanMusic.jpg", "title": "Ayo", "subtitle": "Jones Ato"},
  { "id": 25, "image": "dics.jpg", "title": "Ayo Tomorrow", "subtitle": "Awu Tawiah"}
];
