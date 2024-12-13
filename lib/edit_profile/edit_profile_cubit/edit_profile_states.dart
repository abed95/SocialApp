abstract class EditProfileStates{}

class EditProfileInitialStates extends EditProfileStates{}

class EditProfileImageLoadingStates extends EditProfileStates{}
class EditProfileImageSuccessStates extends EditProfileStates{}
class EditProfileImageErrorStates extends EditProfileStates{
  final String? error;
  EditProfileImageErrorStates(this.error);

}
