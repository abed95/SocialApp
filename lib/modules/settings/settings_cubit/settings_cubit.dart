import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/modules/settings/settings_cubit/settings_states.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class SettingsCubit extends Cubit<SettingsStates>{
  SettingsCubit() : super(SettingsInitialState());
  static SettingsCubit get(context) => BlocProvider.of(context);

}