import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/social_layout/social_cubit/social_cubit.dart';
import 'package:socialapp/layouts/social_layout/social_cubit/social_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        print('Email verified value 18 SL::> ${cubit.model?.isEmailVerified}');
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              buttonText(
                  text: 'SignOut',
                  function: () {
                    signOut(context);
                  }),
              IconButton(
                onPressed: () {
                  cubit.changeThemeMode(
                      fromShared: CacheHelper.getData(key: 'isDark'));
                  print(CacheHelper.getData(key: 'isDark'));
                },
                icon: cubit.isDarkCubit
                    ? const Icon(
                        Icons.brightness_2,
                      )
                    : const Icon(
                        Icons.brightness_4,
                      ),
              ),
            ],
          ),
          body: Column(
            children: [
              if (cubit.model?.isEmailVerified == false)
                Container(
                  height: 50,
                  color: Colors.amber.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Expanded(
                          child: Text(
                            'Please verify your email',
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        buttonText(
                          function: () async {
                            bool? isVerified = await cubit.checkEmailVerification();
                            print('isVerified SL 74::$isVerified');
                            if(!isVerified!){
                              FirebaseAuth.instance.currentUser
                                  ?.sendEmailVerification()
                                  .then((onValue) {
                                showToast(message: 'Check your Email!', state: ToastStates.WARNING);
                              })
                                  .catchError((onError) {
                                showToast(message: onError.toString(), state: ToastStates.ERROR);
                              });
                            }
                          },
                          text: 'send',
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
