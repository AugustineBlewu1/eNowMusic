import 'package:e_now_music/src/models/musicModel.dart';
import 'package:e_now_music/src/services/firebaseDocument.dart';
import 'package:e_now_music/src/startScreens/loginPage.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:e_now_music/src/utils/gridViewMusicList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final newMusicStreams = Document().musics.snapshots();
  List<MusicModel>? musicModel = [];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    getMusics(newMusicStreams: newMusicStreams, musicModel: musicModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPreferredNew(
          context: context,
          logout: () {
            logOutDialog();
          }),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/homeMusic.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Jane Doe',
                  style:
                      context.textTheme.headline3!.copyWith(color: eNowColor),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '24',
                          style: context.textTheme.headline3,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Following",
                          style: context.textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: eNowColor.withOpacity(0.5)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '324.6k',
                          style: context.textTheme.headline3,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Followers",
                          style: context.textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: eNowColor.withOpacity(0.5)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '644.6k',
                          style: context.textTheme.headline3,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Likes",
                          style: context.textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: eNowColor.withOpacity(0.5)),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 48,
                  width: 198,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xfffEB2543))),
                      child: Text(
                        'Follow',
                        style: context.textTheme.headline3!
                            .copyWith(color: Colors.white, fontSize: 20.0),
                      )),
                )
              ],
            ),
          ),

          
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: musicModel!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GridViewMusicList(
                    musicModel: musicModel![index],
                    // closedata: () => close(context, result),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  logOutDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Sure you want to LogOut?',
              style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: SizedBox(
                  width: 100.0,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(eNowColorRed),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('isLoggedIn');
                      prefs.clear();
                      context.removeUntil(
                          context: context, screen: LoginScreen());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('LogOut Successfull'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ));
                    },
                  ),
                ),
              )
            ],
          );
        });
  }
}
