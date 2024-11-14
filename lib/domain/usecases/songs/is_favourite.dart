
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/repository/song/song_repository.dart';
import 'package:spotify_clone/service_locator.dart';
class IsFavourite implements UseCase<bool,String> {
  @override
  Future<bool> call({String ? params}) async  {

    return await sl<SongsRepository>().isFavoriteSong(params!);
  }

  
}