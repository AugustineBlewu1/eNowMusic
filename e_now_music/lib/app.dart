
import 'package:e_now_music/src/startScreens/spalshScreen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'Inter',
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
              headline2: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: ''),
              button: TextStyle(fontSize: 18.0),
              caption: TextStyle(fontSize: 14.0, color: Color(0XFFF32314A))
              
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: Color(0XFFF32314A)
            )            
            ),

        home: SplashScreenMain());
  }
}
