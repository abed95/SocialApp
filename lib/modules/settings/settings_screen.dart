import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/edit_profile/edit_profile_screen.dart';
import 'package:socialapp/modules/settings/settings_cubit/settings_cubit.dart';
import 'package:socialapp/modules/settings/settings_cubit/settings_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = CacheHelper.userModel;
        print('user Data Setting Screen:::19 ${userModel.toString()}');
        return SingleChildScrollView(
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
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0)),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider('${userModel?.cover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: CachedNetworkImageProvider('${userModel?.image}'),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${userModel?.name}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${userModel?.bio}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '123',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '324',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '1.3m',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Add Photos',
                          style: TextStyle(color: defaultColor),
                        ),

                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(
                        Icons.edit,
                        size: 14,
                        color: defaultColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          signOut(context);
                        },
                        child: Text('SignOut', style: TextStyle(color: defaultColor),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
