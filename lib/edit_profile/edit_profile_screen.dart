import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/edit_profile/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:socialapp/edit_profile/edit_profile_cubit/edit_profile_states.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/styles/colors.dart';
import '../shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>EditProfileCubit(),
      child: BlocConsumer<EditProfileCubit,EditProfileStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var userModel = CacheHelper.userModel;
          var profileImage = EditProfileCubit.get(context).profileImage;
          if(userModel!= null){
            nameController.text = userModel.name!;
            bioController.text = userModel.bio!;
          }
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                TextButton(
                  onPressed: () {

                  },
                  child: Text('Update',style: TextStyle(color: defaultColor),),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: Padding(
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
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0)),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        '${userModel?.cover}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
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
                                backgroundImage: profileImage == null ?
                                    CachedNetworkImageProvider('${userModel?.image}')
                                :FileImage(profileImage),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                EditProfileCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
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
                  SizedBox(
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
                    },
                  ),
                  SizedBox(height: 15,),
                  editTextForm(
                    controller: bioController,
                    label: 'Bio',
                    prefixIcon: Icons.edit_attributes_outlined,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'You must enter bio text';
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
