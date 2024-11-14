
import 'package:spotify_clone/data/models/song/song.dart';

abstract class PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongModel> songs;
  PlayListLoaded({required this.songs});
}

class PlayListLoadFailure extends PlayListState {}