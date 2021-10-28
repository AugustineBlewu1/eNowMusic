import 'package:e_now_music/src/otherScreens/bottomNavbar.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';

class MusicUpload extends StatefulWidget {
  const MusicUpload({Key? key}) : super(key: key);

  @override
  _MusicUploadState createState() => _MusicUploadState();
}

class _MusicUploadState extends State<MusicUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPreferred(appBarName: 'Music Upload', context: context),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  items: [
                    DropdownMenuItem(
                      child: Text('Classical'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text('Local'),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Continental',
                      ),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text('Old School'),
                      value: 4,
                    ),
                  ],
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Music Title',
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Music Genre',
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
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
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 115.0,
                  width: 320,
                  child: Center(
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.cloud_upload)),
                        Text('Upload Music File')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    width: 319,
                    height: 49,
                    child: ElevatedButton(
                      onPressed: () {
                        context.removeUntil(
                            context: context, screen: BottomNav());
                      },
                      child: Text('Save'),
                      style: buttonStyle.copyWith(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)))),
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
}
