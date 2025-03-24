import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomCarOverviewContainer extends StatelessWidget {
  final String logoUrl;
  final String carImageUrl;
  final String carName;
  final String rating;
  final String fuelCapacity;
  final bool isManual;
  final int numberOfPeople;
  final String price;

  CustomCarOverviewContainer({
    required this.logoUrl,
    required this.carImageUrl,
    required this.carName,
    required this.rating,
    required this.fuelCapacity,
    required this.isManual,
    required this.numberOfPeople,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
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
                ),
                Spacer(),
                CustomIcons(icon: Icons.favorite),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: Image.network(
                carImageUrl,
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  carName,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    CustomIcons(icon: Icons.star, color: Colors.yellow),
                    CustomText(data: rating)
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIcons(icon: Icons.local_gas_station),
                    SizedBox(width: 4.0),
                    Text(fuelCapacity),
                  ],
                ),
                Row(
                  children: [
                    CustomIcons(icon: Icons.autorenew),
                    SizedBox(width: 4.0),
                    Text(isManual ? 'Manual' : 'Auto'),
                  ],
                ),
                Row(
                  children: [
                    CustomIcons(icon: Icons.people),
                    SizedBox(width: 4.0),
                    Text(numberOfPeople.toString()),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(data:"\$ ${price.toString()}"),
                CustomIcons(icon: Icons.arrow_forward_ios),
              ],
            )
          ],
        ),
      ),
    );
  }
}
