part of 'profile_info_cubit.dart';

@immutable
sealed class ProfileInfoState {}

final class ProfileInfoInitial extends ProfileInfoState {}

final class ProfileInfoSuccess extends ProfileInfoState {
  final UserModel userModel;

  ProfileInfoSuccess({required this.userModel});
  
}


final class ProfileInfoFailure extends ProfileInfoState {}
