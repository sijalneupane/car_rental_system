import 'package:car_rental_system/core/util/color_utils.dart';
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
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: greyColor),
      ),
      child: IconButton(
          onPressed:onPressed,
          icon: CustomIcons(icon: icon,color: color,)),
    );
  }
}
