// import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  Function()? onTap;
  Widget? child;
  CustomInkwell({super.key,this.onTap,this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child:child );
  }
}
