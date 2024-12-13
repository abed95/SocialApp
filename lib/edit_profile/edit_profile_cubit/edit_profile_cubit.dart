import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/edit_profile/edit_profile_cubit/edit_profile_states.dart';
import 'package:socialapp/shared/components/components.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitialStates());
  static EditProfileCubit get(context) => BlocProvider.of(context);

  //Select Image
  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    emit(EditProfileImageLoadingStates());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(EditProfileImageSuccessStates());
    } else {
      showToast(message: 'No image selected', state: ToastStates.ERROR);
      emit(EditProfileImageErrorStates('No Image Selected'));
    }
  }
}
