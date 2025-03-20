import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_image_assets.dart';
import 'package:car_rental_system/widgets/custom_inkwell.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            CustomImageAssets(name: letsStartImagePath),
              ],
            ),
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(data: getStartedTitleStr, fontSize: 30,),
            CustomText(data: getStartedSubTitleStr),
            CustomElevatedbutton(onPressed: (){
              RouteGenerator.navigateToPage(context, Routes.signupRoute);
            }, child: CustomText(data: createAccountStr, color: Colors.white,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
              CustomText(data: alreadyHaveAccountStr),
              CustomInkwell(data:loginStr,onTap:() {
                 RouteGenerator.navigateToPage(context,Routes.loginRoute);
              },)
            ],)
              ],
            )
          ],
        ),
      ),),
    );
  }
}