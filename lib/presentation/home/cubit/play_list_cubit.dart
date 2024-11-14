
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotify_clone/domain/usecases/songs/get_play_list.dart';
import 'package:spotify_clone/presentation/home/cubit/play_list_state.dart';
import 'package:spotify_clone/service_locator.dart';


class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    returnedSongs.fold((l) {
      emit(PlayListLoadFailure());
    }, (data) {
      emit(PlayListLoaded(songs: data));
    });
  }
}
