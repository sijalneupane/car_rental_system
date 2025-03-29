import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

class CustomNoBorderIconButton extends StatelessWidget {
 Function()? onPressed;
  Color? color;
  IconData? icon;
  CustomNoBorderIconButton(
      {super.key, required this.onPressed, this.color,required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed:onPressed,
        icon: CustomIcons (icon: icon,color: color,));
  }
}