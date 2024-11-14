import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository{
  @override
  Future<Either> getUser() async {
   return await sl<AuthFirebaseService>().getUser();
  }

  @override
  Future<Either> signin(signinUserReq) async  {
   return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(createUserReq) async {
   return await sl<AuthFirebaseService>().signup(createUserReq);
  }
  
}