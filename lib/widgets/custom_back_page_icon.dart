import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:flutter/material.dart';

class CustomBackPageIcon extends StatelessWidget {
   IconData? icon;
  CustomBackPageIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: MediaQuery.of(context).size.height*0.05,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: const Color.fromARGB(117, 216, 216, 216), width: 1), // Black border
        ),
        child: IconButton(
          iconSize: 18,
          onPressed: () {
          Navigator.pop(context);
          },
          icon: Icon(icon), // Icon color inside
        ),
      ),
    );
  }
}
