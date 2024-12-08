import 'package:flutter/material.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class SocialLayout extends StatelessWidget {
  final String? name;
  const SocialLayout({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name??''),
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
