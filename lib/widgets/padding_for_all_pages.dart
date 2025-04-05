import 'package:flutter/material.dart';

class PaddingForAllPages extends StatelessWidget {
  Widget? child;
  double? verticalPadding;
  double? horizontalPadding ;
   PaddingForAllPages({super.key,this.child,this.verticalPadding,this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding:   EdgeInsets.symmetric(horizontal:horizontalPadding ?? 12.0,vertical:verticalPadding?? 8),
    child: child,);
  }
}