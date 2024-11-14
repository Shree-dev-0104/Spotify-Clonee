import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/core/configs/theme/app_colours.dart';
import 'package:spotify_clone/data/models/song/song.dart';
import 'package:spotify_clone/presentation/home/cubit/news_songs_cubit.dart';
import 'package:spotify_clone/presentation/home/cubit/news_songs_state.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
            builder: (context, state) {
              if (state is NewsSongsLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }

              if (state is NewsSongsLoaded) {
                return _songs(state.songs);
              }

              return Container();
            },
          )),
    );
  }

  Widget _songs(List<SongModel> songs) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              // Navigate to Song Player
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  SongPlayerPage(
                          songModel: songs[index],
                        )));
              },
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              songs[index].imageUrl!.toString(),
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 40,
                            width: 40,
                            transform: Matrix4.translationValues(10, 10, 0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.isDarkMode
                                    ? AppColors.darkGrey
                                    : const Color(0xffE6E6E6)),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: context.isDarkMode
                                  ? const Color(0xff959595)
                                  : const Color(0xff555555),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      songs[index].title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      songs[index].artist!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 14,
              ),
          itemCount: songs.length),
    );
  }
}
