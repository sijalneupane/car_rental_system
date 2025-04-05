import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

class CustomNoBorderIconButton extends StatelessWidget {
 Function()? onPressed;
  Color? iconColor;
  IconData? icon;Color? iconButtonColor;
  CustomNoBorderIconButton(
      {super.key, required this.onPressed, this.iconColor,required this.icon,this.iconButtonColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed:onPressed,
        color: iconButtonColor,
        icon: CustomIcons (icon: icon,color: iconColor,));
  }
}