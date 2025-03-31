import 'package:car_rental_system/bottom_navbar.dart';
import 'package:car_rental_system/car_details_page.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/enter_otp.dart';
import 'package:car_rental_system/home.dart';
import 'package:car_rental_system/login.dart';
import 'package:car_rental_system/reset_password.dart';
import 'package:car_rental_system/signup.dart';
import 'package:car_rental_system/get_started.dart';
import 'package:car_rental_system/splash_screen.dart';
import 'package:car_rental_system/forgot_password.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static navigateToPage(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.push(context,
        generateRoute(RouteSettings(name: route, arguments: arguments)));
  }

  static navigateToPageWithoutStack(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.pushAndRemoveUntil(
        context,
        generateRoute(RouteSettings(name: route, arguments: arguments)),
        (route) => false);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPgae());
      case Routes.signupRoute:
      return MaterialPageRoute(builder: (_) =>const Signup());
      case Routes.getStartedRoute:
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case Routes.enterOtpRoute:
        return MaterialPageRoute(builder: (_) =>const EnterOtp() );
      case Routes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) =>const ResetPassword() );
      case Routes.bottomNavbarRoute:
        return MaterialPageRoute(builder: (_) =>const BottomNavbar1() );
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) =>const Home() );
      case Routes.carDetailsRoute:
      print( settings.arguments);
        return MaterialPageRoute(builder: (_) =>const CarDetailsPage() );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
