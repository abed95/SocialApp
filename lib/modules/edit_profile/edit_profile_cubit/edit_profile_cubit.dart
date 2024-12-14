import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/edit_profile/edit_profile_cubit/edit_profile_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialapp/shared/network/local/cache_helper.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitialStates());
  static EditProfileCubit get(context) => BlocProvider.of(context);

  //User model from Shared
  var userModel = CacheHelper.userModel;

  //Change ProfileImage
  File? profileImage;
  var picker = ImagePicker();
  // Future<void> getProfileImage() async {
  //   emit(EditProfileImageLoadingStates());
  //   final pickedFile = await picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     profileImage = File(pickedFile.path);
  //     emit(EditProfileImageSuccessStates());
  //   } else {
  //     showToast(message: 'No image selected', state: ToastStates.ERROR);
  //     emit(EditProfileImageErrorStates('No Image Selected'));
  //   }
  // }

  //Change Cover Image
  //Select Image
  Future<void> getProfileImage() async {
    emit(EditProfileImageLoadingStates());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      checkForChanges(
        name: originalName ?? userModel?.name ?? '',
        bio: originalBio ?? userModel?.bio ?? '',
        phone: originalPhone ?? userModel?.phone ?? '',
        profileImage: profileImage,
        coverImage: coverImage,
      );
      emit(EditProfileImageSuccessStates());
    } else {
      showToast(message: 'No image selected', state: ToastStates.ERROR);
      emit(EditProfileImageErrorStates('No Image Selected'));
    }
  }
  /////////////////////////
  File? coverImage;
  // Future<void> getCoverImage() async {
  //   emit(EditProfileCoverLoadingStates());
  //   final pickedFile = await picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     coverImage = File(pickedFile.path);
  //     emit(EditProfileCoverSuccessStates());
  //   } else {
  //     showToast(message: 'No image selected', state: ToastStates.ERROR);
  //     emit(EditProfileCoverErrorStates('No Image Selected'));
  //   }
  // }

  //Upload Image to Fire store Storage
  Future<void> getCoverImage() async {
    emit(EditProfileCoverLoadingStates());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      checkForChanges(
        name: originalName ?? userModel?.name ?? '',
        bio: originalBio ?? userModel?.bio ?? '',
        phone: originalPhone ?? userModel?.phone ?? '',
        profileImage: profileImage,
        coverImage: coverImage,
      );
      emit(EditProfileCoverSuccessStates());
    } else {
      showToast(message: 'No image selected', state: ToastStates.ERROR);
      emit(EditProfileCoverErrorStates('No Image Selected'));
    }
  }
  //////////////////
  String? profileImageUrl;
  void uploadProfileImage() {
    if(profileImage != null){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((onValue) {
      onValue.ref.getDownloadURL().then((onValue) {
        emit(EditProfileUploadImageProfileSuccessStates());
        profileImageUrl = onValue;
        print('Url uploaded value EPC 57:: $onValue');
      }).catchError((onError) {
        profileImageUrl = userModel?.image;
        emit(EditProfileUploadImageProfileErrorStates(onError.toString()));
      });
    }).catchError((onError) {
      profileImageUrl = userModel?.image;
      emit(EditProfileUploadImageProfileErrorStates(onError.toString()));
    });
    }
  }

  //Upload Cover to Fire store Storage
  String? profileCoverUrl;
  void uploadProfileCover() {
    if(coverImage != null){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((onValue) {
      onValue.ref.getDownloadURL().then((onValue) {
        emit(EditProfileUploadCoverSuccessStates());
        profileCoverUrl = onValue;
        print('Url uploaded value EPC 76:: $onValue');
      }).catchError((onError) {
        profileCoverUrl= userModel?.cover;
        emit(EditProfileUploadCoverErrorStates(onError.toString()));
      });
    }).catchError((onError) {
      profileCoverUrl = userModel?.cover;
      emit(EditProfileUploadCoverErrorStates(onError.toString()));
    });
    }
  }

  //Update user data
  void updateUser({String? name, String? phone, String? bio}) {
    emit(EditProfileUpdateUserLoadingStates());
    if(profileImage != null){
      uploadProfileImage();
    }
    if(coverImage != null){
      uploadProfileCover();
    }
    UserModel model = UserModel(
      name: name ?? userModel?.name,
      phone: phone ?? userModel?.phone,
      email: userModel?.email,
      userID: userModel?.userID,
      image: profileImageUrl ?? userModel?.image,
      cover: profileCoverUrl ?? userModel?.cover,
      bio: bio ?? userModel?.bio,
      isEmailVerified: false,

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.userID)
        .update(model.toMap())
        .then((onValue) {
       FirebaseFirestore.instance
          .collection('users')
          .doc(userModel?.userID)
          .get()
          .then((documentSnapshot) async {
        if (documentSnapshot.exists) {
          // Convert FireStore document to UserModel
          model = UserModel.fromJson(documentSnapshot.data()!);
          // Save UserModel to SharedPreferences
          await CacheHelper.saveUserData(model);
          // Emit success state with userModel
        } else {
          print('userUpdated data Error 133 EPC :${onError.toString()} ');
          EditProfileUpdateUserErrorStates(onError.toString());
        }
      }).catchError((onError) {
         EditProfileUpdateUserErrorStates(onError.toString());
       });
      CacheHelper.getUserDataNew().then((onValue){
            userModel = onValue;
            emit(EditProfileUpdateUserSuccessStates());
          }).catchError((onError){
            print('userUpdated data Error 143 EPC :${onError.toString()} ');
            EditProfileUpdateUserErrorStates(onError.toString());
          });
    })
        .catchError((onError) {
      print('userUpdated data Error 148 EPC :${onError.toString()} ');
      EditProfileUpdateUserErrorStates(onError.toString());
    });
  }



  //update just when their is any change
  String? originalName;
  String? originalBio;
  String? originalPhone;
  File? originalProfileImage;
  File? originalCoverImage;

  bool hasChanges = false;

  void setOriginalValues({
    required String name,
    required String bio,
    required String phone,
    File? profileImage,
    File? coverImage,
  }) {
    originalName = name;
    originalBio = bio;
    originalPhone = phone;
    originalProfileImage = profileImage;
    originalCoverImage = coverImage;
  }

  void checkForChanges({
    required String name,
    required String bio,
    required String phone,
    File? profileImage,
    File? coverImage,
  }) {
    bool newHasChanges = name != originalName ||
        bio != originalBio ||
        phone != originalPhone ||
        profileImage != originalProfileImage ||
        coverImage != originalCoverImage;

    if (hasChanges != newHasChanges) {
      hasChanges = newHasChanges;
      emit(EditProfileChangedState());
    }
  }
// Your existing methods for updating the user

}
