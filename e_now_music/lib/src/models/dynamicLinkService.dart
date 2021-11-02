import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_now_music/src/models/musicModel.dart';
import 'package:e_now_music/src/otherScreens/bottomNavbar.dart';
import 'package:e_now_music/src/otherScreens/music/musicPlay.dart';
import 'package:e_now_music/src/services/firebaseDocument.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_now_music/src/utils/navigators.dart';

class DynamicLinkService {
  Future<void> retrievDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        if (deepLink.pathSegments.any((element) => false)) {
        } else if (deepLink.pathSegments.contains('musics')) {
          var id = deepLink.queryParameters['id'];

          var data = await Document().musics.where('id', isEqualTo: id).get();

          context.push(
              screen: MusicPlay(
            musicModel: MusicModel.fromJson(data as Map<String, dynamic>),
          ));
        } else {
          context.push(screen: BottomNav());
        }
      }
    } catch (e) {}
  }
}
