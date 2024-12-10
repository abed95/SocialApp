
import 'package:socialapp/models/user_model/user_model.dart';

import '../../../models/user_model/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  UserModel? userModel;
  LoginSuccessState(this.userModel);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}
class LoginGetUserDataLoadingState extends LoginStates{}
class LoginGetUserDataSuccessState extends LoginStates{
  UserModel? userModel;
  LoginGetUserDataSuccessState(this.userModel);
}
class LoginGetUserDataErrorState extends LoginStates{
  final String error;
  LoginGetUserDataErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginStates{}