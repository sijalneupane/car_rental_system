import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

class CustomBorderIconButton extends StatelessWidget {
  Function()? onPressed;
  Color? color;
  IconData? icon;
  CustomBorderIconButton(
      {super.key, required this.onPressed, this.color,required this.icon});

  @override
   Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle, // Ensures the container is circular
        border: Border.all(color: greyColor),
      ),
      child: IconButton(
        iconSize: 22,
        onPressed: onPressed,
        icon: CustomIcons(
          icon: icon,
          color: color,
        ), 
        // padding: EdgeInsets.zero, // Removes the gap
        constraints: BoxConstraints(), // Removes extra spacing constraints
        splashRadius: 24, // Adds better ripple effect within the circle
      ),
    );
  }

}
