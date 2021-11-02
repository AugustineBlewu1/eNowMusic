import 'dart:convert';
import 'package:e_now_music/src/services/firebaseDocument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, dynamic>? mapUserData;

  @override
  void initState() {
    getShareddata();
    super.initState();
  }

  getShareddata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mapUserData = json.decode(preferences.getString('userData')!);
    });
    return mapUserData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Notifications and Messsages Screen')),
          
        ],
      ),
    );
  }
}
