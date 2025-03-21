import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/login.dart';
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
        return MaterialPageRoute(builder: (_) =>  Signup());
      case Routes.getStartedRoute:
        return MaterialPageRoute(builder: (_) => const GetStarted());
        case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
