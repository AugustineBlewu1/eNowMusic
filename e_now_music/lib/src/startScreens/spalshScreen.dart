import 'package:e_now_music/src/otherScreens/bottomNavbar.dart';
import 'package:e_now_music/src/startScreens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenMain extends StatefulWidget {
  const SplashScreenMain({Key? key}) : super(key: key);

  @override
  _SplashScreenMainState createState() => _SplashScreenMainState();
}

class _SplashScreenMainState extends State<SplashScreenMain> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      route();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Image(
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
            image: AssetImage('assets/homeMusic.png'),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    'eNow',
                    style: theme.headline1!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/copyright.png'),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          '2020 - 2021 Clique Inc',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'All rights reserved',
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Version 1.0',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inter'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  route() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final prefs = preferences.getBool('isLoggedIn') ?? false;

    prefs == true ? Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNav())) 
        :  Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
