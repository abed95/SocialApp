abstract class NewPostStates{}

class NewPostInitialState extends NewPostStates{}
//Create post
class NewPostCreatePostLoadingState extends NewPostStates{}
class NewPostCreatePostSuccessState extends NewPostStates{}
class NewPostCreatePostErrorState extends NewPostStates{
  final String? error;
  NewPostCreatePostErrorState(this.error);
}

