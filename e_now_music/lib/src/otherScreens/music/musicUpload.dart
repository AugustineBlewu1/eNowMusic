import 'dart:io';

import 'package:e_now_music/src/models/musicdataModel.dart';
import 'package:e_now_music/src/services/firebaseStorage.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';
import 'package:provider/provider.dart';

class MusicUpload extends StatefulWidget {
  const MusicUpload({Key? key}) : super(key: key);

  @override
  _MusicUploadState createState() => _MusicUploadState();
}

class _MusicUploadState extends State<MusicUpload> {
  FilePickerResult? result;
  FilePickerResult? resultMusic;
  File? fileImage;
  File? musicFile;
  PlatformFile? musicName;
  String? roleValue;
  bool? loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController musicTitleController = TextEditingController();
  TextEditingController musicGenreController = TextEditingController();
  TextEditingController musicDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dosumentSave = Provider.of<FileStorage>(context, listen: false);
    return Scaffold(
      appBar: appBarPreferred(appBarName: 'Music Upload', context: context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hint: Text('Select Music Role'),
                  validator: (val) {
                    if (val == null) {
                      return 'Select a role';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  items: [
                    DropdownMenuItem(
                      child: Text('Classical'),
                      value: 'Classical',
                    ),
                    DropdownMenuItem(
                      child: Text('Local'),
                      value: 'Local',
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Continental',
                      ),
                      value: 'Continental',
                    ),
                    DropdownMenuItem(
                        child: Text('Old School'), value: 'Old School'),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      roleValue = value;
                    });
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: musicTitleController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Music Title',
                  ),
                  validator: (val) {
                    if (val!.isEmpty) return 'Music Title is required';
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: musicGenreController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Music Genre',
                  ),
                  validator: (val) {
                    if (val!.isEmpty) return 'Music Genre is required';
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: musicDescriptionController,
                  validator: (val) {
                    if (val!.isEmpty) return 'Music Description is required';
                  },
                  keyboardType: TextInputType.number,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Music Description',
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ignore: unnecessary_null_comparison
                    fileImage != null
                        ? Column(
                            children: [
                              SizedBox(
                                  height: 60.0,
                                  width: 60.0,
                                  child: Image.file(fileImage!)),
                              SizedBox(
                                height: 10.0,
                              ),
                              InkWell(
                                  onTap: () {
                                    pickerImage();
                                  },
                                  child: Text(
                                    'Change',
                                    style: context.textTheme.caption!.copyWith(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                  ))
                            ],
                          )
                        : SizedBox(
                            height: 100.0,
                            width: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        pickerImage();
                                      },
                                      icon: Icon(Icons.cloud_upload)),
                                  Text(
                                    'Upload Music Image',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                    musicFile != null
                        ? Column(children: [
                            SizedBox(
                                height: 60.0,
                                width: 120.0,
                                child: Text(
                                  musicName!.name,
                                  style: context.textTheme.headline3!
                                      .copyWith(fontSize: 15.0),
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            InkWell(
                                onTap: () {
                                  pickerMusic();
                                },
                                child: Text(
                                  'Change',
                                  style: context.textTheme.caption!.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ))
                          ])
                        : SizedBox(
                            height: 100.0,
                            width: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        pickerMusic();
                                      },
                                      icon: Icon(Icons.cloud_upload)),
                                  Text(
                                    'Upload Music File',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                loading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: 319,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: () {
                            //context.removeUntil(
                            //     context: context, screen: BottomNav());

                            if (_formKey.currentState!.validate()) {}
                            if (musicFile == null) {
                              return context.showSnackError(
                                  error: 'Music File is required');
                            } else if (fileImage == null) {
                              return context.showSnackError(
                                  error: 'Music Image is required');
                            } else if (_formKey.currentState!.validate() ==
                                false) {
                              return context.showSnackError(
                                  error: 'Check required fields');
                            } else {
                              uploadMusic(dosumentSave);
                            }
                          },
                          child: Text('Save'),
                          style: buttonStyle.copyWith(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)))),
                        )),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickerImage() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileImage = File(result!.files.single.path.toString());
      });
      print(fileImage);
    } else {
      return;
    }
  }

  pickerMusic() async {
    resultMusic = await FilePicker.platform.pickFiles();
    if (resultMusic != null) {
      setState(() {
        musicName = resultMusic!.files.first;
        if (musicName!.name.toString().endsWith('.jpg')) {
          setState(() {
            musicFile == null;
            musicName == null;
          });
          context.showSnackError(error: 'Invalid Music File');
        } else {
          musicFile = File(resultMusic!.files.single.path.toString());
        }

        print(musicName);
      });
    } else {
      return;
    }
  }

  uploadMusic(FileStorage documentSave) async {
    setState(() {
      loading = true;
    });
    MusicData data = MusicData.fromJson({
      'uploadedBy': 'admin',
      'title': musicTitleController.text,
      'role': roleValue,
      'description': musicDescriptionController.text,
      'genre': musicGenreController.text,
      'imageFile': [fileImage, musicFile],
      'isfavorite': false
    });

    await documentSave.uploadImageandMusic(data: data).then((value) {
      print(value);
      context.showSnackSuccess(message: 'Uploaded Successfully');
    }).catchError((onError) {
      print(onError);
      print(onError);
      setState(() {
        loading = false;
        context.showSnackError(error: onError.toString());
      });
    }).whenComplete(() {
      setState(() {
        loading = false;
        context.pop();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
