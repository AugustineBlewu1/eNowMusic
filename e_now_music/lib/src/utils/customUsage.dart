import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';
import 'package:ionicons/ionicons.dart';

ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color(0XFFF32314A),
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));

Color eNowColor = Color(0XFFF32314A);

List<Map<String, dynamic>> musicData = [
  {
    "id": 23,
    "image": "mic.jpg",
    "title": "Sunday Morning",
    "subtitle": "Kwaku Awu"
  },
  {
    "id": 24,
    "image": "humanMusic.jpg",
    "title": "Ayo",
    "subtitle": "Jones Ato"
  },
  {
    "id": 25,
    "image": "dics.jpg",
    "title": "Ayo Tomorrow",
    "subtitle": "Awu Tawiah"
  }
];

PreferredSize? appBarPreferred({BuildContext? context, String? appBarName}) {
  return PreferredSize(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 30, left: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context!).pop();
                },
                icon: Icon(Icons.arrow_back_outlined, color: eNowColor)),
            Text(
              '$appBarName',
              style: context!.textTheme.button!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 42.0,
              width: 42.0,
              child: Image.asset('assets/profile.png'),
            ),
          ],
        ),
      ),
    ),
    preferredSize: Size(MediaQuery.of(context).size.width, 70.0),
  );
}

appBarPreferredwithActions(
    {BuildContext? context, String? share, bool? favourite}) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.only(top: 15.0, right: 30, left: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 33.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
              onPressed: () {
                Navigator.of(context!).pop();
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.cloud_download_rounded,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 15.0,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 15.0,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Ionicons.heart,
                    color: Colors.white,
                  )),
            ],
          ),
        ],
      ),
    ),
  );
}



String? validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern as String);
  if (!regex.hasMatch(value.trim()))
    return 'Enter a valid email: \neg - info@enowmusic.com';
  else
    return null;
}
