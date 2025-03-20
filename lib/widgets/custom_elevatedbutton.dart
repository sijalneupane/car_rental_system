import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:flutter/material.dart';

class CustomElevatedbutton extends StatelessWidget {
  Function()? onPressed;
  Widget? child;
  Color? backgroundColor;
  double? width;
  // double? height;
  CustomElevatedbutton(
      {super.key, required this.onPressed, required this.child,this.width,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: width??MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
             backgroundColor: backgroundColor?? primaryColor,
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 16),
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: child,
        ));
  }
}
