import 'package:car_rental_system/add_car_form.dart';
import 'package:car_rental_system/bottom_navbar.dart';
import 'package:car_rental_system/car_booking_page.dart';
import 'package:car_rental_system/car_details_page.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/enter_otp.dart';
import 'package:car_rental_system/home.dart';
import 'package:car_rental_system/login.dart';
import 'package:car_rental_system/model/car.dart';
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
        return PageRouteBuilder(pageBuilder: (_, __, ___) =>  LoginPgae(fromLogout: settings.arguments as bool? ?? false ,) );
      case Routes.signupRoute:
      return PageRouteBuilder(pageBuilder: (_, __, ___) =>const Signup());
      case Routes.getStartedRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const GetStarted());
      case Routes.forgotPasswordRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const ForgotPassword());
      case Routes.enterOtpRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) =>const EnterOtp() );
      case Routes.resetPasswordRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) =>const ResetPassword() );
      case Routes.bottomNavbarRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) =>const BottomNavbar1() );
      case Routes.homeRoute:
        return PageRouteBuilder(
          transitionDuration:const Duration(milliseconds: 600),pageBuilder: (_, __, ___) =>const Home() );
      case Routes.carDetailsRoute:
      print( settings.arguments);
    
        return PageRouteBuilder(
          transitionDuration:const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => CarDetailsPage(carDetail: settings.arguments as Car,), 
        );
      case Routes.carBookingRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => CarBookingPage(carDetail: settings.arguments as Car ,) );
      case Routes.addCarDetailsRoute:
        return PageRouteBuilder(
        pageBuilder: (_, __, ___) => AddCarForm(car: settings.arguments != null ? settings.arguments as Car : null),
        //  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {  }
        );
      case Routes.viewCarListRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ViewCarListScreen(fromHomePage:settings.arguments as bool? ?? false ) );
      default:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
