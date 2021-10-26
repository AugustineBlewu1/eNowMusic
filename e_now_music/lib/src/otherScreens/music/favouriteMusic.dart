import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteMusic extends StatefulWidget {
  const FavouriteMusic({ Key? key }) : super(key: key);

  @override
  _FavouriteMusicState createState() => _FavouriteMusicState();
}

class _FavouriteMusicState extends State<FavouriteMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Favourite Music')),
    );
  }
}