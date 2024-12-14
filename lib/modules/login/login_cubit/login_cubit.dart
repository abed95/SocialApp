import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/login/login_cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void userLogin({
    required String email,
    required String password,
  }){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((onValue){
      // Fetch user data from FireStore

      getAndSaveUserData(onValue.user?.uid);
    }).catchError((onError){
      emit(LoginErrorState(onError.toString()));
    });
  }

  //Change Password Visibility
  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye : Icons.remove_red_eye_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  Future<void> getAndSaveUserData(String? userId)async {
   await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((documentSnapshot) async {
      if (documentSnapshot.exists) {
        // Convert FireStore document to UserModel
        userModel = UserModel.fromJson(documentSnapshot.data()!);
        // Save UserModel to SharedPreferences
        await CacheHelper.saveUserData(userModel);
        // Emit success state with userModel
        emit(LoginGetUserDataSuccessState(userModel));
      } else {
        emit(LoginGetUserDataErrorState(" LoginCubit 56:User data not found in Firestore."));
      }
    }).catchError((onError) {
      emit(LoginGetUserDataErrorState("Error fetching user data: ${onError.toString()}"));
    });
  }

}