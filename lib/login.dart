import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:flutter/material.dart';

class LoginPgae extends StatelessWidget {
  const LoginPgae({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(onPressed: (){
        RouteGenerator.navigateToPageWithoutStack(context, Routes.signupRoute);
      }, child: Text("Submit")),
    );
  }
}