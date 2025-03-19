import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String data;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  CustomText(
      {super.key, required this.data, this.color, this.fontSize,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      softWrap: true,
      style: TextStyle(color: color ?? Colors.black, fontSize: fontSize, fontWeight:fontWeight ),
    );
  }
}
