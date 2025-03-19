import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:flutter/material.dart';

class CustomElevatedbutton extends StatelessWidget {
  Function()? onPressed;
  Widget? child;
  // double? height;
  CustomElevatedbutton({super.key,required this.onPressed,required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              textStyle: TextStyle(fontSize: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: child,
        ));
  }
}
