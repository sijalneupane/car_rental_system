import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class CustomProfileOptionsButton extends StatelessWidget {
  IconData? icon;
  String data; dynamic Function()? onPressed;
  CustomProfileOptionsButton({super.key,required this.icon,required this.data,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomElevatedbutton(onPressed: onPressed, 
      height: 55,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      borderColor: greyColor,
      child: Row(
        children: [
          CustomIcons(icon: icon,size: 24,),
          CustomSizedBox(width: 0.03,),
          Text(data,style:const  TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),),
          
          const Spacer(),
          CustomIcons(icon:Icons.arrow_forward_ios)
        ],
      )),
    );
  }
}