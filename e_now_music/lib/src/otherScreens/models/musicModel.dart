
class MusicModel {
  int? id;
  String? image;
  String? title;
  String? subtitle;

  MusicModel(Map<String, dynamic> musicData, {this.id, this.image, this.title, this.subtitle});

  MusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    return data;
  }
}