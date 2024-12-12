import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/social_layout/social_cubit/social_cubit.dart';
import 'package:socialapp/layouts/social_layout/social_cubit/social_states.dart';
import 'package:socialapp/modules/settings/settings_cubit/settings_cubit.dart';
import 'package:socialapp/modules/settings/settings_cubit/settings_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit,SettingsStates>(
      listener: (context,state){},
      builder: (context,state){
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
                              image: NetworkImage(
                                '${userModel?.cover}'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('${userModel?.image}'),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Text('${userModel?.name}',
                  style: Theme.of(context).textTheme.bodyMedium,),
                Text('${userModel?.bio}',
                  style: Theme.of(context).textTheme.bodySmall,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.bodyMedium,),
                              Text('post',
                                style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.bodyMedium,),
                              Text('post',
                                style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.bodyMedium,),
                              Text('post',
                                style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.bodyMedium,),
                              Text('post',
                                style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Expanded(child: defaultButton(function: (){}, text: 'Edit Profile',),),
          
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Expanded(child: defaultButton(function: (){
                      signOut(context);
                    }, text: 'Logout',),),
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
