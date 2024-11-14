import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/models/auth/user.dart';
import 'package:spotify_clone/domain/usecases/auth/get_user.dart';
import 'package:spotify_clone/service_locator.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoInitial());

  Future<void> getUSer() async {
    var user = await sl<GetUserUseCase>().call();

    user.fold(
      (l){
        emit(ProfileInfoFailure());
      },
      (r){
        emit(ProfileInfoSuccess(userModel: r));
      },
    );
  }


}
