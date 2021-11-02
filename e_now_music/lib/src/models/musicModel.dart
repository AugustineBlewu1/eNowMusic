class MusicModel {
  String? id;
  String? imageUrl;
  String? musicUrl;
  String? title;
  String? description;
  String? role;
  String? genre;
  bool? isfavorite;

  MusicModel(Map<String, dynamic> musicData,
      {this.id,
      this.imageUrl,
      this.musicUrl,
      this.title,
      this.description,
      this.genre,
      this.isfavorite,
      this.role});

  MusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    musicUrl = json['musicUrl'];
    description = json['description'];
    role = json['role'];
    genre = json['genre'];
    isfavorite = json['isfavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['musicUrl'] = this.musicUrl;
    data['title'] = this.title;
    data['role'] = this.role;
    data['genre'] = this.genre;
    data['isfavorite'] = this.isfavorite;

    data['description'] = this.description;
    return data;
  }
}
