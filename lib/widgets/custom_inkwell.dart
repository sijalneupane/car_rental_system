// import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  String data;
  Function()? onTap;
  CustomInkwell({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(child: CustomText(data: data), onTap: onTap);
  }
}
