import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  String ? title;
  String ? artist;
  num ? duration;
  Timestamp ? releaseDate;
  bool ? isFavorite;
  String ? songId;
  String ? imageUrl;
  String ? songUrl;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
    required this.imageUrl,
    required this.songUrl,
  });

  SongModel.fromJson(Map<String,dynamic> data) {
    title = data['title'];
    imageUrl = data['imageUrl'];
    songUrl = data['songUrl'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
    songId = data['songId'];
    isFavorite = data['isFavorite'];
  }
}

