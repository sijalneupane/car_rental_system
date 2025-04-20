import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    Future.delayed(const Duration(milliseconds: 1500), () async {
      try {
        bool isUserFromFirebaseLogin =
            await checkFirebaseLoggedInUser(context: context);
        if (isUserFromFirebaseLogin) {
          RouteGenerator.navigateToPageWithoutStack(
              context, Routes.bottomNavbarRoute);
        } else {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
          // print('isLoggedIn: $isLoggedIn'); // Debugging line

          if (isLoggedIn == true) {
            RouteGenerator.navigateToPageWithoutStack(
                context, Routes.bottomNavbarRoute);
          } else {
            RouteGenerator.navigateToPageWithoutStack(
                context, Routes.getStartedRoute);
          }
        }
      } catch (e) {
        print('Error retrieving isLoggedIn: $e'); // Debugging line
        RouteGenerator.navigateToPageWithoutStack(
            context, Routes.getStartedRoute);
      }
    });
  }

  Future<bool> checkFirebaseLoggedInUser({
    required BuildContext context,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return true;
    }
    return false;
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
      body: buildNumber == null
          ? Loader.backdropFilter(context)
          : Stack(
              children: [
                Center(
                  child: Image.asset(
                    logoPath,
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CustomText(
                        data: "$versionStr : ${version ?? " Hii"}",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        data: "$buildNoStr : ${buildNumber ?? " Hello"}",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
