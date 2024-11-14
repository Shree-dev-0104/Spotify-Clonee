import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/repository/song/song_repository.dart';
import 'package:spotify_clone/service_locator.dart';
class AddOrRemoveFavouriteSongsUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String ? params}) async  {

    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }

  
}