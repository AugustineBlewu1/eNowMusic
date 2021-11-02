import 'package:e_now_music/src/models/musicModel.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_now_music/src/otherScreens/music/musicPlay.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:e_now_music/src/utils/navigators.dart';

class GridViewMusicList extends StatefulWidget {
  GridViewMusicList({Key? key, this.musicModel}) : super(key: key);
  final MusicModel? musicModel;

  @override
  _GridViewMusicListState createState() => _GridViewMusicListState();
}

class _GridViewMusicListState extends State<GridViewMusicList> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: SizedBox(
        height: 190,
        width: 205,
        child: InkWell(
          onTap: () {
            context.push(
                screen: MusicPlay(
              musicModel: widget.musicModel,
            ));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: eNowColor)],
                  color: Colors.white),
              child: Column(
                children: [
                  widget.musicModel!.imageUrl.toString().startsWith('https')
                      ? CachedNetworkImage(
                          imageUrl: widget.musicModel!.imageUrl.toString(),
                          fit: BoxFit.fitWidth,
                          height: 114,
                          width: 205,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                        )
                      : Image(
                          fit: BoxFit.fitWidth,
                          height: 114,
                          width: 205,
                          image: AssetImage(
                            widget.musicModel!.imageUrl.toString(),
                          )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          widget.musicModel!.title.toString(),
                          style: context.textTheme.headline3!
                              .copyWith(fontSize: 14.0, color: eNowColor),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.musicModel!.title.toString(),
                                style: context.textTheme.caption!.copyWith(
                                    fontSize: 12.0,
                                    color: eNowColor.withOpacity(0.5))),
                            loading == true
                                ? SizedBox(
                                    height: 10.0,
                                    width: 10.0,
                                    child: CircularProgressIndicator())
                                : InkWell(
                                    child: Icon(
                                      Icons.cloud_download,
                                    ),
                                    onTap: () {
                                      downloadMusic();
                                    },
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void downloadMusic() {}
}
