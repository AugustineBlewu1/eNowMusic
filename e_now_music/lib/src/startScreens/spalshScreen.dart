import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 64.0,
                        fontWeight: FontWeight.w700),
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
                  Text(
                    '2020 - 2021 Clique Inc',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
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
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
