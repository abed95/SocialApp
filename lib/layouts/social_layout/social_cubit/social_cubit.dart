import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/social_layout/social_cubit/social_states.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/chats/chats_screen.dart';
import 'package:socialapp/modules/feeds/feeds_screen.dart';
import 'package:socialapp/modules/new_post/new_post_screen.dart';
import 'package:socialapp/modules/search/search_screen.dart';
import 'package:socialapp/modules/settings/settings_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates>{

  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);


  bool? isVerified;
  Future<bool?> checkEmailVerification()async{
    return isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  }


  //Change App Theme Mode
  bool isDarkCubit = false;
  void changeThemeMode({bool? fromShared}){
    if(fromShared != null){
      isDarkCubit = !fromShared;
      CacheHelper.saveData(key: 'isDark', value: isDarkCubit).then((onValue){
        emit(ChangeThemeModeSuccessState());
      }).catchError((onError){
        emit(ChangeThemeModeErrorState());
      });
    }else{
      isDarkCubit = !isDarkCubit;
      CacheHelper.saveData(key: 'isDark', value: isDarkCubit).then((onValue){
        emit(ChangeThemeModeSuccessState());
      }).catchError((onError){
        emit(ChangeThemeModeErrorState());
      });
    }
  }

  //Change Bottom Nav
int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles= [
    'Feeds',
    'Chats',
    'New Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index){
    if(index==2) {
      emit(ChangeNewPostState());
    }else{
      currentIndex = index;
      emit(ChangeBottomNavSuccessState());
    }
  }
}
