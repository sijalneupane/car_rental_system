import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_icon_button.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _phoneNumberController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
          //   CustomText(
          //     data: createAccount,
          //     fontSize: 30,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   CustomText(
          //     data: signupDescription,
          //     fontSize: 14,
          //     color: Colors.grey,
          //   ),
          //   CustomTextformfield(
          //     labelText: phoneNumberStr,
          //     controller: _phoneNumberController,
          //   ),
          //   CustomTextformfield(
          //     obscureText: visible ? false : true,
          //     suffixIcon: IconButton(
          //         onPressed: () {
          //           setState(() {
          //             visible = !visible;
          //           });
          //         },
          //         icon: visible
          //             ? Icon(Icons.visibility_off)
          //             : Icon(Icons.visibility)),
          //     labelText: passwordStr,
          //     controller: _passwordController,
          //   ),
          ],
        ),
      ),
    );
  }
}
