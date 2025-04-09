import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? version;
  String? buildNumber;
  @override
  void initState() {
    super.initState();
    getVersionInfo();
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

  void getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:buildNumber==null?Loader.backdropFilter(context): Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            logoPath,
            width: MediaQuery.of(context).size.width ,
          ),
          Column(
            children: [
              CustomText(data:"Version : ${version ?? " Hii"}",fontSize: 20,fontWeight: FontWeight.bold,),
              CustomText(data:"Build Number : ${buildNumber ??" Hello"}",fontSize: 20,fontWeight: FontWeight.bold,),
            ],
          ),
        ],
      ),
    );
  }
}
