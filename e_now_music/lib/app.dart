import 'package:e_now_music/src/otherScreens/music/musicUpload.dart';
import 'package:e_now_music/src/otherScreens/searchScreen.dart';
import 'package:e_now_music/src/services/firebaseAuth.dart';
import 'package:e_now_music/src/services/firebaseDocument.dart';
import 'package:e_now_music/src/services/firebaseStorage.dart';
import 'package:e_now_music/src/startScreens/spalshScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FirebaseAuthentication()),
        ChangeNotifierProvider(
          create: (context) => FileStorage(),
          lazy: false,
          child: MusicUpload(),
        ),
         ChangeNotifierProvider(
          create: (context) => Document(),
          lazy: false,
          child: SearchScreen(),
        )
      ],
      child: Consumer<FirebaseAuthentication>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: 'Inter',
              textTheme: const TextTheme(
                  headline1: TextStyle(
                      fontSize: 64.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                  headline2: TextStyle(
                      fontSize: 44.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                  headline3: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                  
                  headline6:
                      TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  bodyText2: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700),
                  button: TextStyle(fontSize: 18.0, color: Color(0XFFF32314A)),
                  caption:
                      TextStyle(fontSize: 14.0, color: Color(0XFFF32314A))),
              buttonTheme: ButtonThemeData(buttonColor: Color(0XFFF32314A))),
          routes: {'/': (context) => SplashScreenMain()},
        ),
      ),
    );
  }
}
