import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/cubit/favourite_button_cubit.dart';
import 'package:spotify_clone/core/configs/theme/app_colours.dart';
import 'package:spotify_clone/data/models/song/song.dart';

class FavouriteButton extends StatelessWidget {
  final SongModel songModel;
  const FavouriteButton({
    super.key,
    required this.songModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteButtonCubit(),
      child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
        builder: (context, state) {
          if (state is FavouriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavouriteButtonCubit>().favouriteButtonUpdated(
                  songModel.songId!,
                );
              },
              icon: songModel.isFavorite!
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red.shade300,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: AppColors.darkGrey,
                    ),
            );
          }

          if (state is FavouriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavouriteButtonCubit>().favouriteButtonUpdated(
                  songModel.songId!,
                );
              },
              icon: state.isFavourite
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red.shade300,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: AppColors.darkGrey,
                    ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
