import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_image_assets.dart';
import 'package:car_rental_system/widgets/custom_inkwell.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visible = false;
  bool isTermsAndConditionedAgreed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomBackPageIcon(icon: Icons.close),
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
                  data: createAccountStr,
                  fontSize: 30,
                  textAlign: TextAlign.center,
                ),
                CustomTextformfield(
                  controller: _nameController,
                  labelText: nameStr,
                  hintText: nameHintStr,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return validateNameStr;
                    }
                    return null;
                  },
                ),
                CustomTextformfield(
                  controller: _emailAddressController,
                  labelText: emailAddressStr,
                  hintText: emailAddressHintStr,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return validateEmailAddressStr;
                    }
                    return null;
                  },
                ),
                 CustomTextformfield(
                  obscureText: visible?false:true,
                  controller: _passwordController,
                  labelText: passwordStr,
                  hintText: passwordHintStr,
                  suffixIcon: CustomNoBorderIconButton(
                    icon:visible? Icons.visibility_outlined:Icons.visibility_off_outlined,
                      color: primaryColor,
                    onPressed: () {
                      setState(() {
                        visible=!visible;
                      });
                    },
                  ),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return validatePasswordStr ;
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isTermsAndConditionedAgreed,
                      onChanged: (bool? value) {
                        setState(
                          () {
                            isTermsAndConditionedAgreed = value! ? true : false;
                          },
                        );
                      },
                    ),
                    CustomText(
                      data: agreeTermsAndConditionStr,
                      fontSize: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomElevatedbutton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        
                      }
                    },
                    child: const Text(registerStr)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  children: [
                   const Expanded(child: Divider()),
                    CustomText(data: orStr),
                  const  Expanded(child: Divider()),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedbutton(
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: CustomImageAssets(
                          name: googleLogoPath,
                          height: 40,
                        )),
                    CustomElevatedbutton(
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: CustomImageAssets(
                          name: facebookLogoPath,
                          height: 40,
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(data: alreadyHaveAccountStr),
                    CustomInkwell(
                      child: CustomText(
                        data: loginStr,
                        color: primaryColor,
                      ),
                      onTap: () {
                        RouteGenerator.navigateToPage(
                            context, Routes.loginRoute);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
