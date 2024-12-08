
import 'package:socialapp/models/user_model/user_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  UserModel? model;
  RegisterSuccessState(this.model);
}
class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}
class RegisterCreateUserLoadingState extends RegisterStates{}
class RegisterCreateUserSuccessState extends RegisterStates{
  UserModel? model;
  RegisterCreateUserSuccessState(this.model);
}
class RegisterCreateUserErrorState extends RegisterStates{
  final String error;
  RegisterCreateUserErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates{}