import 'package:e_now_music/src/models/musicModel.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:e_now_music/src/utils/horizontalMusicList.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MusicModel>? musicModel = [];

  @override
  void initState() {
    musicData.forEach((music) {
      musicModel!.add(MusicModel.fromJson(music));
    });
    super.initState();
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
      body: SingleChildScrollView(
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
                        width: 278,
                        child: TextField(
                          decoration:
                              InputDecoration(prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 33.0),
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: TextButton(
                            style: buttonStyle.copyWith(
                                backgroundColor: MaterialStateProperty.all(
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
                            style: context.textTheme.caption!
                                .copyWith(color: eNowColor.withOpacity(0.5)),
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
            SizedBox(
              height: 170,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemCount: musicModel!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HorizontalMusicList(musicModel: musicModel![index]);
                  }),
            ),
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
                    height: 95.0,
                    width: 338.0,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                              height: 50.0,
                              width: 60.0,
                              child: Image(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(
                                    'assets/dics.jpg',
                                  ))),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'True Love',
                              style: context.textTheme.caption!.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text('By Marcela Laskoski',
                                style: context.textTheme.caption!.copyWith(
                                    fontSize: 14.0,
                                    color: eNowColor.withOpacity(0.5))),
                          ],
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        IconButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_circle_filled_sharp,
                              size: 45.0,
                            ))
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
              padding: const EdgeInsets.only(left:33.0),
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
            SizedBox(
              height: 170,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: musicModel!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HorizontalMusicList(musicModel: musicModel![index]);
                  }),
            ),
            SizedBox(
              height: 25.0,
            ),
             
          ],
        ),
      ),
    );
  }
}
