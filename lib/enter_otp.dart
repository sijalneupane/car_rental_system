import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/forgot_password.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_inkwell.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterOtp extends StatefulWidget {
  PhoneEmailOTPDetails phoneEmailOtpDetails;
  EnterOtp({super.key, required this.phoneEmailOtpDetails});

  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  final TextEditingController _pinCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loader = false;
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
        body: Stack(
          children: [
            _ui(),
            loader ? Loader.backdropFilter(context) : SizedBox()
          ],
        ));
  }

  _ui() {
    return Form(
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
                  borderRadius: BorderRadius.circular(8), // Slightly circular
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
                length: 5,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                keyboardType: TextInputType.number,

                validator: (value) {
                  if (value!.isEmpty) {
                    return validateOtpStr;
                  }
                  return null;
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
                    onTap: () async {
                      // Resend OTP logic here
                      if (await EmailOTP.sendOTP(
                        email: widget.phoneEmailOtpDetails.emailAddress??'',
                      )) {
                        DisplaySnackbar.show(
                            context, "OTP resent to ${widget.phoneEmailOtpDetails}");
                      } else {
                        DisplaySnackbar.show(
                            context, "Failed to resend OTP to ${widget.phoneEmailOtpDetails}");
                      }
                    },
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              CustomElevatedbutton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loader = true;
                      });
                      Future.delayed(Duration(seconds: 1), () {
                        print(EmailOTP.getOTP());
                        // print(_pinCodeController.text);
                        if (EmailOTP.verifyOTP(otp: _pinCodeController.text)) {
                          setState(() {
                            loader = true;
                          });
                          RouteGenerator.navigateToPage(
                              context, Routes.resetPasswordRoute,
                              arguments: widget.phoneEmailOtpDetails);
                        } else {
                          DisplaySnackbar.show(context, "OTP didn't match");
                        }
                      });
                      setState(() {
                        loader = true;
                      });
                    }
                  },
                  child: CustomText(
                    data: verifyAccountStr,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
