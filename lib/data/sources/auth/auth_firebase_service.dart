import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/core/configs/constants/app_urls.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';
import 'package:spotify_clone/data/models/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();
}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );

      return const Right("Login Successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return const Left("Enter the correct email");
      } else if (e.code == "invalid-credential") {
        return const Left("User Not Signed In");
      }
      return Left(e.code.toString());
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );
      //  5:50:14
      FirebaseFirestore.instance.collection("Users").doc(data.user!.uid)
      .set({
        'name': createUserReq.fullName.toString(),
        'email': data.user?.email ?? '',
      });

      return const Right("Sign Up was Successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left("Very weak password");
      } else if (e.code == "email-already_in_use") {
        return const Left("An account already exists with that email");
      }
      return Left(e.code.toString());
    }
  }
  
   @override
  Future < Either > getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection('Users').doc(
        firebaseAuth.currentUser?.uid
      ).get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL = firebaseAuth.currentUser?.photoURL ?? AppURLs.defaultImage;
      return Right(userModel);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  

}
