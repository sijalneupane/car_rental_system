import 'package:car_rental_system/core/util/color_utils.dart';
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                CustomImageAssets(name: letsStartImagePath),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomText(
                  data: getStartedTitleStr,
                  fontSize: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomText(
                  data: getStartedSubTitleStr,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomElevatedbutton(
                    onPressed: () {
                      RouteGenerator.navigateToPage(context, Routes.signupRoute);
                    },
                    child: Text(createAccountStr)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(data: alreadyHaveAccountStr),
                    CustomInkwell(
                      child: CustomText(
                        data: loginStr,
                        color: primaryColor,
                      ),
                      onTap: () {
                        RouteGenerator.navigateToPage(context, Routes.loginRoute);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
