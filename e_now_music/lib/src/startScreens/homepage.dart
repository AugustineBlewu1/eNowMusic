import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_now_music/src/models/dynamicLinkService.dart';
import 'package:e_now_music/src/models/musicModel.dart';
import 'package:e_now_music/src/otherScreens/searchDelegate.dart';
import 'package:e_now_music/src/services/firebaseDocument.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:e_now_music/src/utils/horizontalMusicList.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';
import 'package:just_audio/just_audio.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final Stream<QuerySnapshot> musicsStream = Document().musics.snapshots();
  final newMusicStreams = Document().musics.snapshots();
  List<MusicModel>? musicModel = [];
  final DynamicLinkService dynamicLinkService = DynamicLinkService();
  Timer? _timer;
  bool? loading = false;
  late AudioPlayer _audiohere;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    newMusicStreams.forEach((element) {
      element.docs.forEach((DocumentSnapshot document) {
        MusicModel musicModels =
            MusicModel.fromJson(document.data()! as Map<String, dynamic>);
        setState(() {
          musicModel!.add(musicModels);
          setAudioFeed();
        });
      });
    });

    WidgetsBinding.instance?.addObserver(this);
    // getMusicData();
    super.initState();
  }

  setAudioFeed() async {
    _audiohere = AudioPlayer();
    if (musicModel!.isNotEmpty) {
      await _audiohere
          .setAudioSource(
              AudioSource.uri(Uri.parse(musicModel!.first.musicUrl.toString())))
          .then((value) {
        setState(() {
          loading = false;
        });
      });
    } else {
      return;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _timer = new Timer(const Duration(microseconds: 1000), () {
        dynamicLinkService.retrievDynamicLink(context);
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0, right: 33, left: 33.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 42.0,
                      width: 42.0,
                      child: Image.asset('assets/profile.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: 42.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome', style: context.textTheme.caption),
                            Text('Jane Doe',
                                style: context.textTheme.button!
                                    .copyWith(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 33.0),
                  child: Icon(
                    Icons.notifications,
                    color: eNowColor.withOpacity(0.4),
                  ),
                )
              ],
            ),
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 70.0),
      ),
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 33.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Text('Listen to your \nfavourite artists',
                            style: context.textTheme.headline3!
                                .copyWith(color: eNowColor)),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Search Box
                            SizedBox(
                              height: 32.0,
                              width: 250,
                              child: TextField(
                                onTap: () {
                                  showSearch(
                                      context: context,
                                      delegate: SearchMusics(musicModel));
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 33.0),
                              child: SizedBox(
                                height: 32,
                                width: 32,
                                child: TextButton(
                                  style: buttonStyle.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Color(0xFFFDADCE0),
                                      ),
                                      shadowColor: MaterialStateProperty.all(
                                          Color(0xFFFDADCE0)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)))),
                                  child: Image.asset(
                                    'assets/SwitchVertical.png',
                                    fit: BoxFit.fill,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Popular',
                                style: context.textTheme.headline3!
                                    .copyWith(color: eNowColor)),
                            Padding(
                              padding: const EdgeInsets.only(right: 33.0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'View More',
                                  style: context.textTheme.caption!.copyWith(
                                      color: eNowColor.withOpacity(0.5)),
                                  children: [TextSpan(text: '>')],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder(
                      stream: musicsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot?>? snapshots) {
                        if (snapshots!.hasError) {
                          context.showSnackError(error: 'An Error Occured');
                          return Center(child: Text('No Data Here'));
                        }
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          height: 170.0,
                          child: ListView(
                            reverse: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            children: snapshots.data!.docs
                                .map((DocumentSnapshot document) {
                              MusicModel musicModel = MusicModel.fromJson(
                                  document.data()! as Map<String, dynamic>);
                              return HorizontalMusicList(
                                  musicModel: musicModel);
                            }).toList(),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 33.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Recently",
                            style: context.textTheme.button!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      musicModel!.last.imageUrl.toString(),
                                  fit: BoxFit.fitWidth,
                                  height: 45,
                                  width: 150 ,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          SizedBox(
                                    height: 30.0,
                                    width: 40.0,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Column(
                              //   children: [
                              //     Text(
                              //       musicModel!.first.title.toString(),
                              //       style: context.textTheme.caption!.copyWith(
                              //           fontSize: 14.0,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     SizedBox(
                              //       height: 3.0,
                              //     ),
                              //     Text(musicModel!.first.title.toString(),
                              //         style: context.textTheme.caption!
                              //             .copyWith(
                              //                 fontSize: 14.0,
                              //                 color:
                              //                     eNowColor.withOpacity(0.5))),
                              //   ],
                              // ),
                              
                              StreamBuilder<PlayerState?>(
                                  stream: _audiohere.playerStateStream,
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData)
                                      return audioStateWidget(snapshot.data!);
                                    return SizedBox();
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 33.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Recommended for you",
                        style: context.textTheme.button!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  StreamBuilder(
                      stream: musicsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot?>? snapshots) {
                        if (snapshots!.hasError) {
                          context.showSnackError(error: 'An Error Occured');
                          return Center(child: Text('No Data Here'));
                        }
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          height: 170.0,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            children: snapshots.data!.docs
                                .map((DocumentSnapshot document) {
                              MusicModel musicModel = MusicModel.fromJson(
                                  document.data()! as Map<String, dynamic>);
                              return HorizontalMusicList(
                                  musicModel: musicModel);
                            }).toList(),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
    );
  }

  Widget audioStateWidget(PlayerState playerState) {
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
          height: 40.0, width: 40.0, child: CircularProgressIndicator());
    } else if (_audiohere.playing != true) {
      return IconButton(
          onPressed: _audiohere.play,
          icon: Icon(
            Icons.play_circle_fill_rounded,
            size: 45,
          ));
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        onPressed: _audiohere.pause,
        icon: Icon(
          Icons.pause,
          size: 30.0,
        ),
      );
    } else {
      return IconButton(
          onPressed: () {
            _audiohere.seek(Duration.zero,
                index: _audiohere.effectiveIndices?.first);
          },
          icon: Icon(
            Icons.replay,
            size: 30.0,
          ));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }
}
