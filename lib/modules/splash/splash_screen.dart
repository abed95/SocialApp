import 'package:flutter/material.dart';
import 'package:socialapp/layouts/social_layout/social_layout.dart';
import 'package:socialapp/modules/login/login_screen.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initMyData();

  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Text(
          'Social App',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void initMyData() {
    Future.delayed(const Duration(seconds: 3), () async {
      String? userID;
      //1111
      // if(CacheHelper.isLogin()){
      //   navigateAndFinish(context, SocialLayout());
      // }else{
      //   navigateAndFinish(context, LoginScreen());
      // }

      //2222
      if(CacheHelper.isLogin()){
        await CacheHelper.getUserDataNew();
        if(CacheHelper.userModel != null){
          navigateAndFinish(context, SocialLayout());
        }else{
          navigateAndFinish(context, LoginScreen());
        }
      }else{
        navigateAndFinish(context, LoginScreen());
      }



      // CacheHelper.getUserData().then((onValue) {
      //   userID = onValue!.userID;
      //   print('Splash 25 : $userID');
      //   navigateAndFinish(context, SocialLayout());
      // }).catchError((onError) {
      //   navigateAndFinish(context, LoginScreen());
      //   print('Splash 25${onError.toString()}');
      // });
    }
    );
  }
}
