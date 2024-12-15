import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/message_model/message_model.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/chats/chats_cubit/chats_cubit.dart';
import 'package:socialapp/modules/chats/chats_cubit/chats_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  ChatDetailsScreen({this.userModel});

  var mesasgeController = TextEditingController();
  var myModel = CacheHelper.userModel;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        ChatsCubit.get(context).getMessages(userModel?.userID);
        return BlocConsumer<ChatsCubit, ChatsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ChatsCubit.get(context);
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
                    Expanded(
                      child: cubit.messages.isEmpty
                          ? const Center(
                              child: Text('No messages yet'),
                            )
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message = cubit.messages[index];
                                if (myModel?.userID == message?.senderID) {
                                  return buildMyMessage(message);
                                } else {
                                  return buildMessage(message);
                                }
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                              itemCount: cubit.messages.length,
                            ),
                    ),
                    Spacer(),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 5,),
                          Expanded(
                            child: TextFormField(
                              controller: mesasgeController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Write your message here...',
                                hintStyle: TextStyle(color: Colors.grey,fontSize: 14,),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: defaultColor,
                            child: MaterialButton(
                              onPressed: () {
                                if (mesasgeController.text.isNotEmpty) {
                                  cubit.sendMessage(
                                    receiverID: userModel?.userID,
                                    dateTime: DateTime.now().toString(),
                                    text: mesasgeController.text,
                                  );
                                  mesasgeController.clear();
                                }
                              },
                              child: const Icon(
                                Icons.send,
                                size: 25,
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
      },
    );
  }

  Widget buildMessage(MessageModel? model) => Align(
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
            '${model?.text}',
          ),
        ),
      );
  Widget buildMyMessage(MessageModel? model) => Align(
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
            '${model?.text}',style: const TextStyle(color: Colors.white),
          ),
        ),
      );
}
