import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/edit_profile/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:socialapp/modules/edit_profile/edit_profile_cubit/edit_profile_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EditProfileCubit(),
      child: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {
          if (state is EditProfileUpdateUserSuccessStates) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var userModel = CacheHelper.userModel;
          var cubit = EditProfileCubit.get(context);
          var profileImage = cubit.profileImage;
          var coverImage = cubit.coverImage;
          if (userModel != null) {
            nameController.text = userModel.name!;
            bioController.text = userModel.bio!;
            phoneController.text = userModel.phone!;

            // Set the original values in the cubit
            cubit.setOriginalValues(
              name: userModel.name!,
              bio: userModel.bio!,
              phone: userModel.phone!,
            );
          }

          // Add listeners to track changes in the text fields
          cubit.setOriginalValues(
            name: userModel!.name!,
            bio: userModel.bio!,
            phone: userModel.phone!,
            profileImage: cubit.profileImage,
            coverImage: cubit.coverImage,
          );

          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                TextButton(
                  onPressed: () {
                    cubit.hasChanges
                        ? () {
                            cubit.updateUser(
                              name: nameController.text,
                              bio: bioController.text,
                              phone: phoneController.text,
                            );
                          }
                        : null; //Disable button if no changes
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: cubit.hasChanges ? defaultColor : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? CachedNetworkImageProvider(
                                              '${userModel.cover}')
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    EditProfileCubit.get(context)
                                        .getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                      color: defaultColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? CachedNetworkImageProvider(
                                          '${userModel?.image}')
                                      : FileImage(profileImage),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  EditProfileCubit.get(context)
                                      .getProfileImage();
                                },
                                icon: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                      color: defaultColor,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    editTextForm(
                      controller: nameController,
                      label: 'Name',
                      prefixIcon: Icons.person,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'You must enter your name';
                        }
                        return null;
                      },
                      onChange: (value) => cubit.checkForChanges(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                        profileImage: cubit.profileImage,
                        coverImage: cubit.coverImage,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    editTextForm(
                      controller: phoneController,
                      label: 'Phone',
                      prefixIcon: Icons.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'You must enter phone';
                        }
                        return null;
                      },
                      onChange: (value) => cubit.checkForChanges(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                        profileImage: cubit.profileImage,
                        coverImage: cubit.coverImage,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    editTextForm(
                      controller: bioController,
                      label: 'Bio',
                      prefixIcon: Icons.edit_attributes_outlined,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'You must enter bio text';
                        }
                        return null;
                      },
                      onChange: (value) => cubit.checkForChanges(
                name: nameController.text,
                bio: bioController.text,
                phone: phoneController.text,
                profileImage: cubit.profileImage,
                coverImage: cubit.coverImage,
              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
