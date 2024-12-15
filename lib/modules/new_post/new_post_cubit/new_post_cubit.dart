import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/new_post/new_post_cubit/new_post_states.dart';

class NewPostCubit extends Cubit<NewPostStates> {
  NewPostCubit() : super(NewPostInitialState());
  static NewPostCubit get(context) => BlocProvider.of(context);

  //Create New Post
  void createNewPost({
    String? name,
    String? userId,
    String? image,
    String? dateTime,
    String? text,
  }) {
    emit(NewPostCreatePostLoadingState());




  }
}
