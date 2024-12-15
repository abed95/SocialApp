import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/chats/chats_cubit/chats_cubit.dart';
import 'package:socialapp/modules/chats/chats_cubit/chats_states.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  ChatDetailsScreen({this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatsCubit,ChatsStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                  CachedNetworkImageProvider('${userModel?.image}'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${userModel?.name}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(10),
                        topEnd: Radius.circular(10),
                        topStart: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'data',
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(10),
                        topEnd: Radius.circular(10),
                        topStart: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'data',
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15,),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write your message here ...',
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        color: defaultColor,
                        child: MaterialButton(
                          onPressed: () {

                          },
                          child: const Icon(
                            Icons.send,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
