import 'package:flutter/material.dart';

class CustomImageNetwork extends StatelessWidget {
  String name;
  double? height;
  double? width;
  BoxFit? fit;
   CustomImageNetwork({super.key,required this.name,this.height,this.width,this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.network(name,height: height,width: width,fit:fit ,);
  }
}