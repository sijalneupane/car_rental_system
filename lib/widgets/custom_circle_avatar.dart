import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  ImageProvider<Object>? backgroundImage;
  double? radius;
  CustomCircleAvatar({super.key, required this.backgroundImage,this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius:radius?? 25, backgroundImage: backgroundImage);
  }
}
