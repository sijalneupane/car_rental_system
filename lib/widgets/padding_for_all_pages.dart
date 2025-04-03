import 'package:flutter/material.dart';

class PaddingForAllPages extends StatelessWidget {
  Widget? child;
   PaddingForAllPages({super.key,this.child});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding:  const EdgeInsets.symmetric(horizontal:  15.0,vertical: 5),
    child: child,);
  }
}