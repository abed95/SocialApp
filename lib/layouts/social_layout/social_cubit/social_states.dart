import 'package:socialapp/models/user_model/user_model.dart';

abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

//Get User Data
class SocialGetUserDataLoadingState extends SocialStates{}
class SocialGetUserDataSuccessState extends SocialStates{
  UserModel? userModel;
  SocialGetUserDataSuccessState(this.userModel);
}
class SocialGetUserDataErrorState extends SocialStates{
  final String error;
  SocialGetUserDataErrorState(this.error);
}

//Change Theme data
class ChangeThemeModeSuccessState extends SocialStates{}
class ChangeThemeModeErrorState extends SocialStates{}