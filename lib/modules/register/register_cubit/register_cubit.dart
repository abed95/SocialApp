import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/register/register_cubit/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  //Register a New User
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((onValue){
      createUser(
          name: name,
          email: email,
          phone: phone,
          userID: onValue.user!.uid
      );

    }).catchError((onError){
      emit(RegisterErrorState(onError.toString()));
    });
  }

  //Create User
  void createUser({
    required String name,
    required String email,
    required String phone,
    required String userID,
}){
    UserModel? model = UserModel(
      name: name,
      email: email,
      phone: phone,
      userID: userID,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .set(model.toMap()).then((onValue)async{
          // save the user data in shared
        await  CacheHelper.saveUserData(model)
              .then((onValue){
                emit(RegisterSuccessState(model));
          })
              .catchError((onError){
                emit(RegisterErrorState(onError.toString()));
          });
            emit(RegisterCreateUserSuccessState(model));
    }).catchError((onError){
      emit(RegisterCreateUserErrorState(onError.toString()));
    });
  }


  //Change Password Visibility
  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye : Icons.remove_red_eye_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

}