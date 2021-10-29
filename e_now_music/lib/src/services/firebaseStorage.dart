import 'dart:io';

import 'package:e_now_music/src/models/musicdataModel.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FileStorage extends ChangeNotifier {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  Future<void> uploadImageandmusic({MusicData? data}){

    for (var imageorMusic in data!.imageFile!){
      postImageandMusic(imageorMusicPath: imageorMusic).then((value) => null)
    }


  }

  

  Future<dynamic> postImageandMusic({File? imageorMusicPath}) async {
    //String fileName = data['fileName'];

    // firebase_storage.SettableMetadata settableMetadata = await firebase_storage.SettableMetadata(
    //   customMetadata: {
    //     'musicTitle': data
    //   }
    // );

    firebase_storage.UploadTask uploadTask =
        storage.ref(imageorMusicPath!.path).putFile(imageorMusicPath,
       );
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);

    print(taskSnapshot.ref.getDownloadURL());
    print(taskSnapshot.ref.getDownloadURL());
    return taskSnapshot.ref.getDownloadURL();
  }
}
