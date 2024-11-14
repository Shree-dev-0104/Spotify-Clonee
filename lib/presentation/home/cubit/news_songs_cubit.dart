import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/songs/get_news_songs.dart';
import 'package:spotify_clone/presentation/home/cubit/news_songs_state.dart';
import 'package:spotify_clone/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();
    returnedSongs.fold((l) {
      emit(NewsSongsLoadFailure());
    }, (data) {
      emit(NewsSongsLoaded(songs: data));
    });
  }

  @override
  void onChange(Change<NewsSongsState> change) {
    super.onChange(change);
  }
}
