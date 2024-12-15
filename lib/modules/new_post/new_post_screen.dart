import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/new_post/new_post_cubit/new_post_cubit.dart';
import 'package:socialapp/modules/new_post/new_post_cubit/new_post_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/colors.dart';

import '../../shared/network/local/cache_helper.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = CacheHelper.userModel;

    return BlocProvider(
      create: (BuildContext context) => NewPostCubit(),
      child: BlocConsumer<NewPostCubit, NewPostStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: defaultColor,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            CachedNetworkImageProvider('${userModel?.image}'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              '${userModel?.name}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'What\'s in your mind...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image,color: defaultColor,),
                              SizedBox(width: 5,),
                              Text('Add photo',style: TextStyle(color: defaultColor,),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('# Tags',style: TextStyle(color: defaultColor),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
