import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:defaultAppBar(
          context: context,
          title: 'New Post',
      ),
    );
  }
}
