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
    Future.delayed(const Duration(seconds: 3), () {
      String? userID;
      String? name;
      CacheHelper.getUserData().then((onValue) {
        userID = onValue!.userID;
        name = onValue.name;
        print('Splash 25 : $userID');
        navigateAndFinish(context, SocialLayout(name:name,));
      }).catchError((onError) {
        navigateAndFinish(context, LoginScreen());
        print('Splash 25${onError.toString()}');
      });
    }
    );
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
}
