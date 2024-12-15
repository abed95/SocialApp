abstract class ChatsStates{}

class ChatsInitialState extends ChatsStates{}

// get All Users
class ChatsGetAllUsersLoadingState extends ChatsStates{}
class ChatsGetAllUsersSuccessState extends ChatsStates{}
class ChatsGetAllUsersErrorState extends ChatsStates{
  final String? error;

  ChatsGetAllUsersErrorState(this.error);
}
//Messages
class ChatsSendMessageSuccessState extends ChatsStates{}
class ChatsSendMessageErrorState extends ChatsStates{
  final String? erorr;
  ChatsSendMessageErrorState(this.erorr);
}
class ChatsGetMessageSuccessState extends ChatsStates{}
class ChatsGetMessageErrorState extends ChatsStates{
  final String? error;

  ChatsGetMessageErrorState(this.error);
}