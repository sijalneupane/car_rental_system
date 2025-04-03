import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_inkwell.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterOtp extends StatefulWidget {
  const EnterOtp({super.key});

  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  TextEditingController _pinCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // FocusNode _focusNode=FocusNode();
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
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  CustomText(
                    data: verifyAccountStr,
                    fontSize: 30,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  PinCodeTextField(
                    // focusNode: _focusNode,
                    // autoFocus: true,
                    // boxShadows: const [
                    //   BoxShadow(
                    //     offset: Offset(0, 1),
                    //     color: Colors.black12,
                    //     blurRadius: 10,
                    //   ),
                    // ],
                    controller: _pinCodeController,
                    showCursor: true,
                    cursorColor: primaryColor,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius:
                          BorderRadius.circular(8), // Slightly circular
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeColor: const Color(
                          0x1F999999), // Active pin (current pin) border color
                      inactiveColor:
                          const Color(0x1F999999), // Inactive pins border color
                      selectedColor:
                          primaryColor, // Color when pin is selected (focused)
                      // activeFillColor: Colors.white, // Fill color for the active pin
                      // inactiveFillColor: Colors.white, // Fill color for the inactive pins
                      // selectedFillColor: Colors.white, // Fill color when the pin is selected
                    ),
                    appContext: context,
                    length: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return validateOtpStr;
                      }return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(data: didntReceiveOtpStr),
                      CustomInkwell(
                        child: CustomText(
                          data: resendOtpStr,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  CustomElevatedbutton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(_pinCodeController.text);
                          RouteGenerator.navigateToPage(context, Routes.resetPasswordRoute);
                        }
                      },
                      child: CustomText(
                        data: verifyAccountStr,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
