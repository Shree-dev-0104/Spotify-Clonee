part of 'favourite_button_cubit.dart';

@immutable
sealed class FavouriteButtonState {}

final class FavouriteButtonInitial extends FavouriteButtonState {}

final class FavouriteButtonUpdated extends FavouriteButtonState {
  final bool isFavourite;

  FavouriteButtonUpdated({required this.isFavourite});
  
}
