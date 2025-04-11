import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomCarOverviewContainer extends StatelessWidget {
  final String logoUrl;
  final String carImageUrl;
  final String carName;
  final String rating;
  final String fuelCapacity;
  final String carType;
  final String numberOfPeople;
  final String price;
 final dynamic Function()? onPressed;

  const CustomCarOverviewContainer({
    super.key,
    required this.logoUrl,
    required this.carImageUrl,
    required this.carName,
    required this.rating,
    required this.fuelCapacity,
    required this.carType,
    required this.numberOfPeople,
    required this.price,
    this.onPressed,
    
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          border: Border.all(
            color: greyColor,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: greyColor.withOpacity(0.5),
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  logoUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                const Spacer(),
                CustomIcons(icon: Icons.favorite),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Center(
              child: Image.network(
                carImageUrl,
                height: MediaQuery.of(context).size.height * 0.18,
                fit: BoxFit.contain,
                // This is giving me error and only gives me hello text only
                
                    
                // errorBuilder: (context, error, stackTrace){
                //   return Container(
                //     child: Image.network(carPlaceholderImageUrl,fit: BoxFit.contain,
                    
                //     ),
                //     height: MediaQuery.of(context).size.height * 0.18,
                //   );
                // },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    carName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CustomIcons(icon: Icons.star, color: Colors.yellow),
                    CustomText(data: rating)
                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIcons(
                        icon: Icons.local_gas_station, color: greyColor),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0055),
                    Text(fuelCapacity),
                  ],
                ),
                Row(
                  children: [
                    CustomIcons(icon: Icons.autorenew, color: greyColor),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0055),
                    Text(carType),
                  ],
                ),
                Row(
                  children: [
                    CustomIcons(
                      icon: Icons.people,
                      color: greyColor,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0055),
                    Text(numberOfPeople.toString()),
                  ],
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(data: "\$ ${price.toString()} $perDayStr"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.035,
                  ),
                  Expanded(
                    child: CustomElevatedbutton(
                      onPressed:onPressed,
                      child: const Text(
                        rentalNowStr,
                      ),
                      // () {
                      //   // RouteGenerator.navigateToPage(
                      //   //     context, Routes.carDetailsRoute);
                      // },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
