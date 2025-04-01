import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  ImageProvider<Object>? backgroundImage;
  CustomCircleAvatar({super.key, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: 25, backgroundImage: backgroundImage);
  }
}
