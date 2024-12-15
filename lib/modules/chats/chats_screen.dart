import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/chat_details/chat_details_screen.dart';
import 'package:socialapp/modules/chats/chats_cubit/chats_cubit.dart';
import 'package:socialapp/modules/chats/chats_cubit/chats_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ChatsCubit, ChatsStates>(
      listener: (context, state) {
        if(state is ChatsGetAllUsersErrorState){
          showToast(message: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = ChatsCubit.get(context);
        return state is ChatsGetAllUsersLoadingState
            ? const Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(context,cubit.users[index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.users.length,
        );
      },
    );
  }

  Widget buildChatItem(context,UserModel? userModel) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(userModel: userModel,));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider('${userModel?.image}'),
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
        ),
      );
}
