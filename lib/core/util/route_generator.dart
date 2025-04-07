import 'package:car_rental_system/add_car_form.dart';
import 'package:car_rental_system/bottom_navbar.dart';
import 'package:car_rental_system/car_booking_page.dart';
import 'package:car_rental_system/car_details_page.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/enter_otp.dart';
import 'package:car_rental_system/home.dart';
import 'package:car_rental_system/login.dart';
import 'package:car_rental_system/reset_password.dart';
import 'package:car_rental_system/signup.dart';
import 'package:car_rental_system/get_started.dart';
import 'package:car_rental_system/forgot_password.dart';
import 'package:car_rental_system/view_car_list_screen.dart';
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
        return MaterialPageRoute(builder: (_) => const LoginPgae(),settings: settings);
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
        return MaterialPageRoute(builder: (_) =>const CarDetailsPage(),settings: settings );
      case Routes.carBookingRoute:
        return MaterialPageRoute(builder: (_) =>const CarBookingPage() );
      case Routes.addCarDetailsRoute:
        return MaterialPageRoute(builder: (_) =>const AddCarForm() );
      case Routes.viewCarListRoute:
        return MaterialPageRoute(builder: (_) =>const ViewCarListScreen(),settings: settings );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
