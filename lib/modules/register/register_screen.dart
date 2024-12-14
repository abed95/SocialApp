import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/social_layout/social_layout.dart';
import 'package:socialapp/modules/register/register_cubit/register_cubit.dart';
import 'package:socialapp/modules/register/register_cubit/register_states.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // my work ibrahem
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterErrorState){
            showToast(message: state.error, state: ToastStates.ERROR);
          }

          if(state is RegisterSuccessState){
            CacheHelper.getUserDataNew().then((onValue){
              showToast(message: 'Register Success ${state.model?.name}', state: ToastStates.SUCCESS);
              navigateAndFinish(context, SocialLayout());
            }).catchError((onError){
              showToast(message: 'Register Get User data error Login Screen', state: ToastStates.ERROR);
            });
          }else if(state is RegisterCreateUserErrorState){
            showToast(message: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context,state){
          print("RegisterScreen BlocProvider BlocConsumer ${state.toString()}");
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        titleText(title: 'Register', context: context),
                        bodyText(
                            body: 'Register now to browse an amazing offers',
                            context: context),
                        const SizedBox(
                          height: 45,
                        ),
                        editTextForm(
                          controller: nameController,
                          label: 'User Name',
                          prefixIcon: Icons.person,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'You must enter your name';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                          isPassword: RegisterCubit.get(context).isPassword,
                          prefixIcon: Icons.lock,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixIconPressed: () {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          validator: (String? value){
                            if (value!.isEmpty) {
                              return 'You must enter password';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        editTextForm(
                          controller: phoneController,
                          label: 'Phone number',
                          prefixIcon: Icons.phone,
                          validator: (String? value){
                            if (value!.isEmpty) {
                              return 'You must enter phone number';
                            }
                          },
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context)=>defaultButton(
                            function: () {
                              print('inside Button');
                              FocusScope.of(context).unfocus();
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }

                            },
                            text: 'register',
                          ),
                          fallback: (context)=>const Center(
                            child: CircularProgressIndicator(
                              color: defaultColor,
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    // my work
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: Scaffold(
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
                      titleText(title: 'Register', context: context),
                      bodyText(
                          body: 'Register now to browse an amazing offers',
                          context: context),
                      const SizedBox(
                        height: 45,
                      ),
                      editTextForm(
                        controller: nameController,
                        label: 'User Name',
                        prefixIcon: Icons.person,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'You must enter your name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
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
                        isPassword: RegisterCubit.get(context).isPassword,
                        prefixIcon: Icons.lock,
                        suffix: RegisterCubit.get(context).suffix,
                        suffixIconPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        validator: (String? value){
                          if (value!.isEmpty) {
                            return 'You must enter password';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      editTextForm(
                        controller: phoneController,
                        label: 'Phone number',
                        prefixIcon: Icons.phone,
                        validator: (String? value){
                          if (value!.isEmpty) {
                            return 'You must enter phone number';
                          }
                        },
                        onSubmit: (value){
                          if(formKey.currentState!.validate()){
                            RegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<RegisterCubit,RegisterStates>(
                        listener: (context,state){
                          // if(state is RegisterSuccessState){
                          //   if(state.loginModel?.status == true)
                          //   {
                          //     print({'The state is :',state});
                          //     print({'The Status of request is :',state.loginModel?.status});
                          //     CacheHelper.saveData(
                          //       key: 'token',
                          //       value: state.loginModel?.data?.token,)
                          //         .then((onValue){
                          //       token = state.loginModel!.data!.token!;
                          //     }).catchError((onError){
                          //       print({'The error is :',onError});
                          //     });
                          //
                          //     CacheHelper.saveUserData(state.loginModel).then((onValue){
                          //       navigateAndFinish(context, HomeLayout(),);
                          //       showToast(message: state.loginModel?.message, state: ToastStates.SUCCESS);
                          //     }).catchError((onError){
                          //       showToast(message: state.loginModel?.message, state: ToastStates.ERROR);
                          //     });
                          //   }else{
                          //     print({'The Status of request is :',state});
                          //     showToast(
                          //       state: ToastStates.ERROR,
                          //       message: state.loginModel?.message,
                          //     );
                          //   }
                          // }
                          if(state is RegisterErrorState){
                            showToast(message: state.error, state: ToastStates.ERROR);
                          }

                          if(state is RegisterCreateUserSuccessState){
                            navigateAndFinish(context, SocialLayout());
                          }else if(state is RegisterCreateUserErrorState){
                            showToast(message: state.error, state: ToastStates.ERROR);
                          }
                        },
                        builder: (context,state){
                          print("RegisterScreen BlocProvider BlocConsumer ${state.toString()}");
                          return ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context)=>defaultButton(
                              function: () {
                                print('inside Button');
                                FocusScope.of(context).unfocus();
                                if(formKey.currentState!.validate()){
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }

                              },
                              text: 'register',
                            ),
                            fallback: (context)=>const Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            ),
                          );
                        },
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
}
}
