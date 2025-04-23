import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/hide_keyboard.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_checkbox.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Future<bool> _isEmailValid(String email) async {
    try {
      // Check if email exists in Firestore
      final firestore = FirebaseFirestore.instance;
      final userQuery = await firestore
          .collection('Register') // Fixed typo: 'Regsiters' to 'Registers'
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isNotEmpty) {
        return true;
      }

      // // Check if email is associated with Google Sign-In using Firebase Authentication
      // final auth = FirebaseAuth.instance;
      // // ignore: deprecated_member_use
      // final signInMethods = await auth.fetchSignInMethodsForEmail(email);

      // // Return true if Google is one of the sign-in methods
      // if (signInMethods.contains('google.com')) {
      //   return true;
      // }

      return false;
    } catch (e) {
      debugPrint('Error checking email validity: $e');
      return false;
    }
  }

  final TextEditingController _emailPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool usingPhoneNumber = false;
  bool loader = false;
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

  Widget _ui() {
    return Form(
      key: _formKey,
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
                controller: _emailPhoneController,
                labelText: phoneNumberEmailLabelStr,
                hintText: phoneNumberEmailHintStr,
                validator: (p0) {
                  if (usingPhoneNumber) {
                    if (p0!.isEmpty) {
                      return validatePhoneStr;
                    } else if (!phoneRegex.hasMatch(p0)) {
                      return validatePhoneRegexStr;
                    }
                  } else if (p0!.isEmpty) {
                    return validateEmailAddressStr;
                  } else if (!emailRegex.hasMatch(p0)) {
                    return validateEmailAddressRegexStr;
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomCheckbox(
                  value: usingPhoneNumber,
                  onChanged: (p0) {
                    setState(() {
                      usingPhoneNumber = p0!;
                    });
                  },
                  checkBoxTitle: "Use Phone Number"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomElevatedbutton(
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      HideKeyboard.hideKeyboard(context);
                      setState(() {
                        loader = true;
                      });
                      PhoneEmailOTPDetails? phoneEmailOTPDetails;
                      if (usingPhoneNumber) {
                        FirebaseAuth auth = FirebaseAuth.instance;
                      await  auth.verifyPhoneNumber(
                          phoneNumber:"+977 ${_emailPhoneController.text}",
                          timeout: Duration(minutes: 1),
                          verificationCompleted: (phoneAuthCredential) {
                            DisplaySnackbar.show(context,"Verification completed: ${phoneAuthCredential.smsCode}");
                          },
                          verificationFailed: (error) {
                            throw Exception("${error.message}<----------->${error.code}");
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            // phoneEmailOTPDetails=PhoneEmailOTPDetails(phoneNumber:_emailPhoneController.text ,usingPhoneNumber: true);
                            // RouteGenerator.navigateToPageWithoutStack(context,Routes.enterOtpRoute);
                            DisplaySnackbar.show(context,
                                "OTP has been sent to the ${_emailPhoneController.text}");
                          },
                          codeAutoRetrievalTimeout: (verificationId) {},
                        );
                      } else if (await _isEmailValid(
                          _emailPhoneController.text)) {
                        if (await EmailOTP.sendOTP(
                          email: _emailPhoneController.text,
                        )) {
                              phoneEmailOTPDetails=PhoneEmailOTPDetails(emailAddress:_emailPhoneController.text );
                          RouteGenerator.navigateToPage(
                              context, Routes.enterOtpRoute,
                              arguments: phoneEmailOTPDetails);
                        } else {
                          DisplaySnackbar.show(context,
                              "Failed to send  password reset OTP to the ${_emailPhoneController.text}");
                          throw Exception("Failed to send OTP");
                        }
                      } else {
                        DisplaySnackbar.show(context,
                            "${_emailPhoneController.text} is not a registered email for this app");
                      }
                    }
                  } catch (e) {
                    DisplaySnackbar.show(context, e.toString());
                  } finally {
                    setState(() {
                      loader = false;
                    });
                  }
                },
                child: CustomText(
                  data: sendCodeStr,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneEmailOTPDetails {
  //sending otp to phone Number
  // sendOtpFromPhoneAuth() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //     timeout: Duration(minutes: 2),
  //     verificationCompleted: (phoneAuthCredential) {},
  //     verificationFailed: (error) {},
  //     codeSent: (verificationId, forceResendingToken) {},
  //     codeAutoRetrievalTimeout: (verificationId) {},
  //   );
  // }

  String? emailAddress;
  String? phoneNumber;
  String? otp;
  bool usingPhoneNumber;
  PhoneEmailOTPDetails({this.emailAddress, this.phoneNumber, this.otp,this.usingPhoneNumber=false});
}
