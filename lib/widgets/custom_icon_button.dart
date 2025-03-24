import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  Function()? onPressed;
  Color? color;
  IconData? icon;
  CustomIconButton(
      {super.key, required this.onPressed, this.color,required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.black,
        onPressed:onPressed,
        icon: CustomIcons(icon: icon,color: color,));
  }
}
