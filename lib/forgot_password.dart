import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomBackPageIcon(icon: Icons.arrow_back),
      ),
      body: Form(
        key:_formKey ,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomText(
                  data: forgotPasswordStr,
                  fontSize: 30,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                CustomTextformfield(
                  labelText: emailAddressStr,
                  hintText: emailAddressHintStr,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return validateEmailAddressStr;
                    } return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                CustomElevatedbutton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    RouteGenerator.navigateToPage(context, Routes.enterOtpRoute);
                  }
                }, child: CustomText(data: sendCodeStr,color: Colors.white,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
