import 'package:get_it/get_it.dart';
import 'package:spotify_clone/data/repository/auth/auth_repository_implementation.dart';
import 'package:spotify_clone/data/repository/song/song_repository_implementation.dart';
import 'package:spotify_clone/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone/data/sources/songs/song_firebase_service.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone/domain/repository/song/song_repository.dart';
import 'package:spotify_clone/domain/usecases/auth/get_user.dart';
import 'package:spotify_clone/domain/usecases/auth/signin.dart';
import 'package:spotify_clone/domain/usecases/auth/signup.dart';
import 'package:spotify_clone/domain/usecases/songs/add_or_remove_favourite_songs.dart';
import 'package:spotify_clone/domain/usecases/songs/get_favourite_songs.dart';
import 'package:spotify_clone/domain/usecases/songs/get_news_songs.dart';
import 'package:spotify_clone/domain/usecases/songs/get_play_list.dart';
import 'package:spotify_clone/domain/usecases/songs/is_favourite.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImplementation());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImplementation());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<SongsRepository>(SongRepositoryImplementation());

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImplementation());

  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());

  sl.registerSingleton<AddOrRemoveFavouriteSongsUseCase>(
      AddOrRemoveFavouriteSongsUseCase());

  sl.registerSingleton<IsFavourite>(IsFavourite());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<GetFavouriteSongsUseCase>(GetFavouriteSongsUseCase());
}
