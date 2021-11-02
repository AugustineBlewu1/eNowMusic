import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_now_music/src/models/musicModel.dart';
import 'package:e_now_music/src/otherScreens/music/audioPlay.dart';
import 'package:e_now_music/src/services/firebaseAuth.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MusicPlay extends StatefulWidget {
  const MusicPlay({Key? key, this.musicModel}) : super(key: key);

  final MusicModel? musicModel;

  @override
  _MusicPlayState createState() => _MusicPlayState();
}

class _MusicPlayState extends State<MusicPlay> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthentication>(context, listen: false);
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
                child: CachedNetworkImage(
                  imageUrl: widget.musicModel!.imageUrl.toString(),
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                child: AudioPlay(
              musicModel: widget.musicModel,
            ))
          ],
        ),
        appBarPreferredwithActions(
            context: context,
            share: () {
              sharePostMusic(
                  musicModel: widget.musicModel, authentication: auth);
            })
      ]),
    );
  }

  sharePostMusic(
      {MusicModel? musicModel, FirebaseAuthentication? authentication}) async {
    var link = await authentication!.shareLink(
        channel: 'musics',
        imageUrl: musicModel!.imageUrl,
        id: musicModel.id,
        title: musicModel.title,
        description: musicModel.description);
    if (link != null) {
      Share.share(link);
    }
  }
}
