import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

class CustomProfileOptionsButton extends StatelessWidget {
  IconData? icon;
  String data;
  CustomProfileOptionsButton({super.key,required this.icon,required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedbutton(onPressed: (){

    }, 
    backgroundColor: Colors.transparent,
    
    child: Row(
      children: [
        CustomIcons(icon: icon),
        Text(data),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ));
  }
}