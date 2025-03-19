import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomRoleSelect extends StatelessWidget {
  IconData? icon;
  String roleTitle;
  Function()? onPressed;
  CustomRoleSelect({super.key, this.icon, required this.roleTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width 
      // color: Colors.white,
      ,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
        onPressed:onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIcons(
              icon: icon,
              size: 50,
              color: primaryColor,
            ),
            CustomText(
              data: roleTitle,
              fontSize: 20,
            )
          ],
        ),
      ),
    );
  }
}
