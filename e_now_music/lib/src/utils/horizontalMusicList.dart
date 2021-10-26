import 'package:e_now_music/src/otherScreens/models/musicModel.dart';
import 'package:e_now_music/src/otherScreens/music/musicPlay.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';

class HorizontalMusicList extends StatelessWidget {
  const HorizontalMusicList({
    Key? key,
    required this.musicModel,
  }) : super(key: key);
  final MusicModel musicModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: 205,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            context.push(screen: MusicPlay());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: eNowColor)],
                  color: Colors.white),
              child: Column(
                children: [
                  Image(
                      fit: BoxFit.fitWidth,
                      height: 114,
                      width: 205,
                      image: AssetImage(
                        ("assets/${musicModel.image}"),
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
                          musicModel.title.toString(),
                          style: context.textTheme.headline3!
                              .copyWith(fontSize: 14.0, color: eNowColor),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(musicModel.subtitle.toString(),
                                style: context.textTheme.caption!.copyWith(
                                    fontSize: 12.0,
                                    color: eNowColor.withOpacity(0.5))),
                            InkWell(
                              child: Icon(
                                Icons.cloud_download,
                              ),
                              onTap: () {},
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
}
