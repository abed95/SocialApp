import 'package:flutter/material.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social App => ${CacheHelper.userModel?.name}'),
        actions: [
          TextButton(
            onPressed: () {
              signOut(context);
            },
            child: Text('SignOut'),
          ),
        ],
      ),
    );
  }
}
