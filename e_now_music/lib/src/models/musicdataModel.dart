import 'dart:io';

class MusicData {
  String? uploadedBy;
  String? title;
  String? role;
  String? description;
  String? genre;
  bool? isfavorite;
  List<File?>? imageFile;

  MusicData(
      {this.uploadedBy,
      this.title,
      this.role,
      this.description,
      this.genre,
      this.isfavorite,
      this.imageFile});

  MusicData.fromJson(Map<String, dynamic> json) {
    uploadedBy = json['uploadedBy'];
    title = json['title'];
    role = json['role'];
    description = json['description'];
    genre = json['genre'];
    isfavorite = json['isfavorite'];
    imageFile = json['imageFile'].cast<File>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedBy'] = this.uploadedBy;
    data['title'] = this.title;
    data['role'] = this.role;
    data['description'] = this.description;
    data['genre'] = this.genre;
    data['isfavorite'] = this.isfavorite;
    data['imageFile'] = this.imageFile;
    return data;
  }
}
