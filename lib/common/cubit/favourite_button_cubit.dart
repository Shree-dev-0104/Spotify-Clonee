
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotify_clone/domain/usecases/songs/add_or_remove_favourite_songs.dart';
import 'package:spotify_clone/service_locator.dart';

part 'favourite_button_state.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState> {
  FavouriteButtonCubit() : super(FavouriteButtonInitial());

  void favouriteButtonUpdated(String songId) async {
    var result = await sl<AddOrRemoveFavouriteSongsUseCase>().call(params: songId);

    result.fold(
      (left) {},
      (right) {
        emit(FavouriteButtonUpdated(
          isFavourite: right,
        ));
      },
    );
  }
}
