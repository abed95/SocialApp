import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/message_model/message_model.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/chats/chats_cubit/chats_states.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatsInitialState());
  static ChatsCubit get(context) => BlocProvider.of(context);

  List<UserModel?> users = [];
  var userModel = CacheHelper.userModel;
  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((onValue) {
        onValue.docs.forEach((element) {
          if (element.data()['userID'] != userModel!.userID)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(ChatsGetAllUsersSuccessState());
      }).catchError((onError) {
        emit(ChatsGetAllUsersErrorState(onError.toString()));
      });
    }
  }

  // Send Messages
  void sendMessage({
    required String? receiverID,
    required String? dateTime,
    required String? text,
  }) {
    MessageModel? model = MessageModel(
      senderID: userModel?.userID,
      receiverID: receiverID,
      text: text,
    );
    //set Sender chat message
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.userID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((onValue) {
      emit(ChatsSendMessageSuccessState());
    }).catchError((onError) {
      emit(ChatsSendMessageErrorState(onError.toString()));
    });
    //set Receiver chat message
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(userModel?.userID)
        .collection('messages')
        .add(model.toMap())
        .then((onValue) {
      emit(ChatsSendMessageSuccessState());
    }).catchError((onError) {
      emit(ChatsSendMessageErrorState(onError.toString()));
    });
  }

  //Get messages
  List<MessageModel?> messages = [];
  void getMessages(String? receiverID) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.userID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((onData) {
      messages = [];
      onData.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(ChatsGetMessageSuccessState());
    });
  }
}
