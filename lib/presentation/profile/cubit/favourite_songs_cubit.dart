import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/models/song/song.dart';
import 'package:spotify_clone/domain/usecases/songs/get_favourite_songs.dart';
import 'package:spotify_clone/presentation/profile/cubit/favourite_songs_state.dart';
import 'package:spotify_clone/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());
  
  
  List<SongModel> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
   
   var result  = await sl<GetFavouriteSongsUseCase>().call();
   
   result.fold(
    (l){
      emit(
        FavoriteSongsFailure()
      );
    },
    (r){
      favoriteSongs = r;
      print("r " + r.toString());
      emit(
        FavoriteSongsLoaded(favoriteSongs: favoriteSongs)
      );
    }
  );
}

 @override
  void onChange(Change<FavoriteSongsState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print("Change - "+change.toString());
  }

}