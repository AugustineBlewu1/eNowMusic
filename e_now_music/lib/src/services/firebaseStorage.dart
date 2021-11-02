import 'dart:convert';
import 'dart:io';
import 'package:e_now_music/src/models/musicdataModel.dart';
import 'package:e_now_music/src/services/firebaseDocument.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

class FileStorage extends ChangeNotifier {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  List<String?>? images = [];

  Future<dynamic> uploadImageandMusic({MusicData? data}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final mapUserData = json.decode(preferences.getString('userData')!);

    notifyListeners();
    for (var imageorMusic in data!.imageFile!) {
      await postImageandMusic(imageorMusicPath: imageorMusic)
          .then((downloadUrl) {
        images!.add(downloadUrl);
        print(images!.length);
        if (images!.length == 2) {
          String documentId = DateTime.now().microsecondsSinceEpoch.toString();
          Document().musics.add({
            'id': documentId,
            'imageUrl': images![0],
            'musicUrl': images![1],
            'title': data.title,
            'role': data.role,
            'description': data.description,
            'genre': data.genre,
            'isfavorite': false
          }).then((value) async {
            final movies = await Document()
                .users
                .where('email', isEqualTo: mapUserData!['email'])
                .get()
                .then((value) => value.docs.first.id);
            Document().users.doc(movies).collection('myMusic').add({
              'id': documentId,
              'imageUrl': images![0],
              'musicUrl': images![1],
              'title': data.title,
              'role': data.role,
              'description': data.description,
              'genre': data.genre,
            });
          }).catchError((onError) {
            print(onError);

            notifyListeners();
            throw Exception(onError);
          }).whenComplete(() {
            images = [];
            images!.clear;
            notifyListeners();
          });
        }
      });
    }
  }

  Future<dynamic> postImageandMusic({File? imageorMusicPath}) async {
    //String fileName = data['fileName'];

    // firebase_storage.SettableMetadata settableMetadata = await firebase_storage.SettableMetadata(
    //   customMetadata: {
    //     'musicTitle': data
    //   }
    // );
    notifyListeners();
    firebase_storage.UploadTask uploadTask =
        storage.ref(imageorMusicPath!.path).putFile(
              imageorMusicPath,
            );
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);

    taskSnapshot.ref.getDownloadURL().then((value) {
      print(value);
      print(value);
    });
    return taskSnapshot.ref.getDownloadURL();
  }
}
