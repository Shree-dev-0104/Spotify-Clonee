import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/common/widgets/appbar/basic_app_bar.dart';
import 'package:spotify_clone/presentation/profile/cubit/favourite_songs_cubit.dart';
import 'package:spotify_clone/presentation/profile/cubit/favourite_songs_state.dart';
import 'package:spotify_clone/presentation/profile/cubit/profile_info_cubit.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        backgroundColor: Color(0xff2C2B2B),
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(
            height: 30,
          ),
          //_favoriteSongs(context),
        ],
      ),
    );
  }
}

Widget _profileInfo(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 3.5,
    width: double.infinity,
    decoration: BoxDecoration(
      color: context.isDarkMode ? Color(0xff2C2B2B) : Colors.white,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: BlocProvider(
      create: (context) => ProfileInfoCubit()..getUSer(),
      child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
        builder: (context, state) {
          if (state is ProfileInfoInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileInfoSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        state.userModel.imageURL!.toString(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(state.userModel.email!),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.userModel.fullName!,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
          if (state is ProfileInfoFailure) {
            return const Center(
              child: Text("Please Try Again"),
            );
          }
          return Container();
        },
      ),
    ),
  );
}

Widget _favoriteSongs(BuildContext context) {
  return BlocProvider(
    create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FAVORITE SONGS',
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
            builder: (context, state) {
              if (state is FavoriteSongsLoading) {
                return const CircularProgressIndicator();
              }
              if (state is FavoriteSongsLoaded) {
                print("Success" + state.favoriteSongs.toString());
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      print(state.favoriteSongs[0].artist!.toString());
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SongPlayerPage(
                                          songModel:
                                              state.favoriteSongs[index])));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        state.favoriteSongs[index].imageUrl!
                                            .toString(),
                                      ))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.favoriteSongs[index].title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      state.favoriteSongs[index].artist!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(state.favoriteSongs[index].duration
                                    .toString()
                                    .replaceAll('.', ':')),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                    itemCount: state.favoriteSongs.length);
              }
              if (state is FavoriteSongsFailure) {
                return const Text('Please try again.');
              }
              return Container();
            },
          )
        ],
      ),
    ),
  );
}
