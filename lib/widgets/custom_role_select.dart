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
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width ,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ElevatedButton(
        onPressed:onPressed,
        child: Center(
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
      ),
    );
  }
}
