import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to next screen after 3 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
        print('isLoggedIn: $isLoggedIn'); // Debugging line

        if (isLoggedIn == true) {
          RouteGenerator.navigateToPageWithoutStack(
              context, Routes.bottomNavbarRoute);
        } else {
          RouteGenerator.navigateToPageWithoutStack(
              context, Routes.getStartedRoute);
        }
      } catch (e) {
        print('Error retrieving isLoggedIn: $e'); // Debugging line
        // RouteGenerator.navigateToPageWithoutStack(context, Routes.getStartedRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logoPath,
              width: MediaQuery.of(context).size.width * 0.75,
            )
          ],
        ),
      ),
    );
  }
}
