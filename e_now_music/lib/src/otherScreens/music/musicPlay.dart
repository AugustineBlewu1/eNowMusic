import 'package:e_now_music/src/otherScreens/music/audioPlay.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:flutter/material.dart';

class MusicPlay extends StatefulWidget {
  const MusicPlay({Key? key}) : super(key: key);

  @override
  _MusicPlayState createState() => _MusicPlayState();
}

class _MusicPlayState extends State<MusicPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                child: Image(
                  image: AssetImage("assets/mic.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox( child: AudioPlay())
          ],
        ),
        
        appBarPreferredwithActions(context: context)
      ]),
    );
  }
}
