import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_role_select.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RoleSelection extends StatelessWidget {
  // String? userType;
 const RoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
            CustomRoleSelect(
              roleTitle: findTrip,
              icon: Icons.person_search_outlined,
              onPressed: () {
                // routeName = Routes.welcomeDriverRoute;
              },
            ),
            CustomRoleSelect(
              roleTitle: findDriver,
              icon: Icons.shopping_cart_outlined,
              onPressed: () {
                // routeName = Routes.welcomeCustomerRoute;
              },
            ),
            CustomElevatedbutton(
                onPressed: () {
                  RouteGenerator.navigateToPage(
                    context,
                    // routeName!,
                    Routes.welcomeRoute
                  );
                },
                child: CustomText(data: continueStr,color: Colors.white,))
                    ],
                  ),
          )),
    );
  }
}
