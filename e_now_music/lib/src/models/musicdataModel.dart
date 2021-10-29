

import 'dart:io';

class MusicData {
  String? uploadedBy;
  String? title;
  String? role;
  String? description;
  List<File?>? imageFile;

  MusicData(
      {this.uploadedBy,
      this.title,
      this.role,
      this.description,
      this.imageFile});

  MusicData.fromJson(Map<String, dynamic> json) {
    uploadedBy = json['uploadedBy'];
    title = json['title'];
    role = json['role'];
    description = json['description'];
    imageFile = json['imageFile'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedBy'] = this.uploadedBy;
    data['title'] = this.title;
    data['role'] = this.role;
    data['description'] = this.description;
    data['imageFile'] = this.imageFile;
    return data;
  }
}
