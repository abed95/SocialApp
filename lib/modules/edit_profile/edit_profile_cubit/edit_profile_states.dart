abstract class EditProfileStates{}

class EditProfileInitialStates extends EditProfileStates{}

//Change Profile Image States
class EditProfileImageLoadingStates extends EditProfileStates{}
class EditProfileImageSuccessStates extends EditProfileStates{}
class EditProfileImageErrorStates extends EditProfileStates{
  final String? error;
  EditProfileImageErrorStates(this.error);
}
//Change Cover Image
class EditProfileCoverLoadingStates extends EditProfileStates{}
class EditProfileCoverSuccessStates extends EditProfileStates{}
class EditProfileCoverErrorStates extends EditProfileStates{
  final String? error;
  EditProfileCoverErrorStates(this.error);
}

//Upload Image Profile
class EditProfileUploadImageProfileLoadingStates extends EditProfileStates{}
class EditProfileUploadImageProfileSuccessStates extends EditProfileStates{}
class EditProfileUploadImageProfileErrorStates extends EditProfileStates{
  final String? error;
  EditProfileUploadImageProfileErrorStates(this.error);
}

//Upload Cover Image

class EditProfileUploadCoverLoadingStates extends EditProfileStates{}
class EditProfileUploadCoverSuccessStates extends EditProfileStates{}
class EditProfileUploadCoverErrorStates extends EditProfileStates{
  final String? error;
  EditProfileUploadCoverErrorStates(this.error);
}

//Update User Data
class EditProfileUpdateUserLoadingStates extends EditProfileStates{}
class EditProfileUpdateUserSuccessStates extends EditProfileStates{}
class EditProfileUpdateUserErrorStates extends EditProfileStates{
  final String? error;
  EditProfileUpdateUserErrorStates(this.error);
}

class EditProfileChangedState extends EditProfileStates{}

