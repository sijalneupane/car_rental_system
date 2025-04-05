import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_inkwell.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool visible1 = false;
  bool visible2 = false;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomBackPageIcon(),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CustomBackPageIcon( icon: Icons.close),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.04,
                // ),
                CustomText(
                  data: newPasswordStr,
                  fontSize: 30,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                CustomTextformfield(
                  obscureText: visible1 ? false : true,
                  controller: _passwordController,
                  labelText: passwordStr,
                  hintText: passwordHintStr,
                  suffixIcon: CustomNoBorderIconButton(
                    icon: visible1
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    iconColor: primaryColor,
                    onPressed: () {
                      setState(() {
                        visible1 = !visible1;
                      });
                    },
                  ),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return validatePasswordStr;
                    }
                    return null;
                  },
                ),
                CustomTextformfield(
                  obscureText: visible2 ? false : true,
                  controller: _confirmPasswordController,
                  labelText: confirmPasswordStr,
                  hintText: passwordHintStr,
                  suffixIcon: CustomBorderIconButton(
                    icon: visible2
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: primaryColor,
                    onPressed: () {
                      setState(() {
                        visible2 = !visible2;
                      });
                    },
                  ),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return validatePasswordStr;
                    } else if (p0 != _passwordController.text) {
                      return passwordDidntMatchStr;
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomElevatedbutton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        RouteGenerator.navigateToPageWithoutStack(
                            context, Routes.loginRoute);
                      }
                    },
                    child: const Text(resetPasswordStr)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
