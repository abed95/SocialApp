import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/social_layout/social_cubit/social_states.dart';
import 'package:socialapp/models/user_model/user_model.dart';

class SocialCubit extends Cubit<SocialStates>{

  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);


  UserModel? model;
  void getUserData(){

  }
}