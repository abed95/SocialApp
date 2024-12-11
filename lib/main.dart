import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/social_layout/social_cubit/social_states.dart';
import 'package:socialapp/modules/splash/splash_screen.dart';
import 'package:socialapp/shared/bloc_observer.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/styles/themes.dart';
import 'layouts/social_layout/social_cubit/social_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> SocialCubit()..getUserData()),
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
        builder: (context,state){
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: SocialCubit.get(context).isDarkCubit
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: SplashScreen(),
            );
        },
      ),
    );
  }
}
