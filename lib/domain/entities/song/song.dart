
import 'package:cloud_firestore/cloud_firestore.dart';
// The format is same as the Songs Collection that i created
class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavorite;
  final String songId; 
  final String imageUrl;
  final String songUrl;

  SongEntity({
    required this.title,
    required this.imageUrl,
    required this.songUrl,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId
  });   
}