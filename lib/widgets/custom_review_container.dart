import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_system/widgets/custom_circle_avatar.dart';

class CustomReviewContainer extends StatelessWidget {
  String reviewerName;
  String reviewerInfo;
  String reviewedDateTime;

  CustomReviewContainer({super.key,required this.reviewerName ,required this.reviewerInfo,required this.reviewedDateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
          children: [
             CustomCircleAvatar (
              backgroundImage:const NetworkImage(
                'https://randomuser.me/api/portraits/men/85.jpg',
              ),
            ),
            CustomSizedBox(width: 0.02), // Spacer
            Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(data: reviewerName),
                CustomText(
                  data: reviewerInfo,
                  color: greyColor,
                ),
              ],
            ),
            const Spacer(),
            CustomIcons(icon: Icons.watch_later_outlined),
            CustomText(data: reviewedDateTime),
          ],
        ),
        CustomSizedBox(height:0.005),
        CustomText(data: "adjkasdkja aksdjhjkjrewororiwoier shcjhbfjhdgjksfgbgsfd gsfhsdfjghkskdjghjsdgfgjsdhfgrtiuwreoidsbaiufhdahf",color: greyColor,textAlign: TextAlign.left,)
        , 
        CustomSizedBox(height: 0.005,),
        Divider()
    
        ],
      ),
    );
  }
}