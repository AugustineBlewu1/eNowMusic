
import 'package:e_now_music/src/models/musicModel.dart';
import 'package:e_now_music/src/utils/gridViewMusicList.dart';
import 'package:flutter/material.dart';

class SearchMusics extends SearchDelegate<MusicModel> {
  final List<MusicModel>? musicModel;
  MusicModel? result;

  SearchMusics(this.musicModel)
      : super(
          searchFieldLabel: 'Search Music',
          //searchFieldStyle: TextStyle(fontSize: 10.0, decorationThickness: 1.0, inherit: false) ,
          // searchFieldDecorationTheme: InputDecorationTheme(
          //   hintStyle: TextStyle(color: Colors.green, fontSize: 10.0),
          // ),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
       backgroundColor: Colors.white,
       
       inputDecorationTheme: theme.inputDecorationTheme.copyWith(
         labelStyle: TextStyle(color: Colors.black),
         hintStyle: theme.primaryTextTheme.headline6!.copyWith(
           color: Colors.white
         ),
      ),
      textTheme: theme.primaryTextTheme.copyWith(
        headline3: TextStyle(color: Colors.black)
      ),
      primaryTextTheme: TextTheme(
        headline3: TextStyle(color: Colors.black)
      )

    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
          // close(context, result!);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestedMusicModel = musicModel!.where((music) {
      return music.title!.toLowerCase().contains(query.toLowerCase());
    });
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8,
      ),
      itemCount: suggestedMusicModel.length,
      itemBuilder: (BuildContext context, int index) {
        return GridViewMusicList(
          musicModel: suggestedMusicModel.elementAt(index),
          // closedata: () => close(context, result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedMusicModel = musicModel!.where((music) {
      return music.title!.toLowerCase().contains(query.toLowerCase());
    });
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8,
      ),
      itemCount: suggestedMusicModel.length,
      itemBuilder: (BuildContext context, int index) {
        return GridViewMusicList(
          musicModel: suggestedMusicModel.elementAt(index),
          // closedata: () => close(context, result),
        );
      },
    );
  }
}



