
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  String data;
  Widget Function(BuildContext) builder;
   CustomInkwell({super.key,required this.data,required this.builder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:CustomText(data:data) ,
      onTap: () {
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:builder ),(Route<dynamic> route) => false);
      },
    );
  }
}