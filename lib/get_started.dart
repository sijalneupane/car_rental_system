import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_image_assets.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
        children: [
          CustomImageAssets(name: letsStartImagePath),
          CustomText(data: getStartedTitleStr, fontSize: 30,),
          CustomText(data: getStartedSubTitleStr),
          CustomElevatedbutton(onPressed: (){
            RouteGenerator.navigateToPageWithoutStack(context, Routes.signupRoute);
          }, child: CustomText(data: createAccountStr))
        ],
      )),
    );
  }
}