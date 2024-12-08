import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/social_layout/social_layout.dart';
import 'package:socialapp/modules/login/login_cubit/login_cubit.dart';
import 'package:socialapp/modules/login/login_cubit/login_states.dart';
import 'package:socialapp/modules/register/register_screen.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/colors.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            showToast(message: 'Login Success ${state.userModel!.name}', state: ToastStates.SUCCESS);
            navigateAndFinish(context, SocialLayout(name:state.userModel!.name,));
          }else if(state is LoginErrorState){
            showToast(message: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          titleText(title: 'LOGIN', context: context),
                          bodyText(
                              body: 'Login now to browse an amazing offers',
                              context: context),
                          const SizedBox(
                            height: 45,
                          ),
                          editTextForm(
                            controller: emailController,
                            label: 'Email',
                            prefixIcon: Icons.email_outlined,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'You must enter an email';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          editTextForm(
                            controller: passwordController,
                            label: 'Password',
                            isPassword: LoginCubit.get(context).isPassword,
                            prefixIcon: Icons.lock,
                            suffix: LoginCubit.get(context).suffix,
                            suffixIconPressed: () {
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            validator: (String? value){
                              if (value!.isEmpty) {
                                return 'You must enter password';
                              }
                            },
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context)=>defaultButton(
                              function: () {
                                print('inside Button');
                                FocusScope.of(context).unfocus();
                                if(formKey.currentState!.validate()){
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'login',
                            ),
                            fallback: (context)=>const Center(child: CircularProgressIndicator(color: defaultColor,),),
                          ),
                          Row(
                            children: [
                              bodyText(body: 'Don\'t have an account?', context: context),
                              buttonText(text: 'register now', context: context,function: (){
                                print('register button taped');
                                navigateTo(context, RegisterScreen());
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
