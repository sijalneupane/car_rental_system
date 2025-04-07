import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/hide_keyboard.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_image_assets.dart';
import 'package:car_rental_system/widgets/custom_inkwell.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/util/legacy_to_async_migration_util.dart';
// ···

class LoginPgae extends StatefulWidget {
  const LoginPgae({super.key});

  @override
  State<LoginPgae> createState() => _LoginPgaeState();
}

class _LoginPgaeState extends State<LoginPgae> {
  // TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visible = false;
  bool rememberMe = false;
  bool loader = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ui(),
            loader ? Loader.backdropFilter(context) : const SizedBox()
          ],
        ));
  }

  Widget ui() {
    
  var fromLogOut = ModalRoute.of(context)?.settings.arguments as bool? ?? false;
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               fromLogOut?SizedBox(): CustomBackPageIcon(),

                // CustomBackPageIcon( icon: Icons.close),
                CustomSizedBox(
                  height: 0.04,
                ),
                CustomText(
                  data: welcomeBackStr,
                  // fontSize: 30,
                  isFormTitle: true,
                  textAlign: TextAlign.center,
                ),
                CustomSizedBox(
                  height: 0.04,
                ),
                CustomTextformfield(
                  controller: _emailAddressController,
                  labelText: emailAddressStr,
                  hintText: emailAddressHintStr,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return validateEmailAddressStr;
                    } else if (!emailRegex.hasMatch(p0)) {
                      return validateEmailAddressRegexStr;
                    }
                    return null;
                  },
                ),
                CustomTextformfield(
                  obscureText: visible ? false : true,
                  controller: _passwordController,
                  labelText: passwordStr,
                  hintText: passwordHintStr,
                  suffixIcon: CustomNoBorderIconButton(
                    icon: visible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    iconColor: primaryColor,
                    onPressed: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                  ),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return validatePasswordStr;
                    } else if (!passwordRegex.hasMatch(p0)) {
                      return validatePasswordRegexStr;
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (bool? value) {
                        setState(
                          () {
                            rememberMe = value! ? true : false;
                          },
                        );
                      },
                    ),
                    CustomText(data: rememberMeStr),
                    const Spacer(),
                    CustomInkwell(
                      child: CustomText(
                        data: forgotPasswordStr,
                        color: primaryColor,
                      ),
                      onTap: () {
                        RouteGenerator.navigateToPage(
                            context, Routes.forgotPasswordRoute);
                      },
                    )
                  ],
                ),
                CustomSizedBox(
                  height: 0.03,
                ),
                CustomElevatedbutton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loader = true;
                      });
                      HideKeyboard.hideKeyboard(context);
                      Future.delayed(const Duration(seconds: 2), () async {
                        // var data = {
                        //   "name": _nameController.text.trim(),
                        //   "email": _emailAddressController.text.trim(),
                        //   "password": _passwordController.text.trim(),
                        // };
                        try {
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          await firestore
                              .collection("Register")
                              .where("email",
                                  isEqualTo:
                                      _emailAddressController.text.trim())
                              .where("password",
                                  isEqualTo: _passwordController.text.trim())
                              .get()
                              .then((value) async {
                            if (value.docs.isNotEmpty) {
                              if (rememberMe) {
                                // Obtain shared preferences.
                                const SharedPreferencesOptions
                                    sharedPreferencesOptions =
                                    SharedPreferencesOptions();
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await migrateLegacySharedPreferencesToSharedPreferencesAsyncIfNecessary(
                                  legacySharedPreferencesInstance: prefs,
                                  sharedPreferencesAsyncOptions:
                                      sharedPreferencesOptions,
                                  migrationCompletedKey: 'migrationCompleted',
                                );
                                await prefs.setBool('isLoggedIn', true);
                              }
                              DisplaySnackbar.show(
                                  context, loginSuccessfullyStr);
                              RouteGenerator.navigateToPageWithoutStack(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  Routes.bottomNavbarRoute);
                            } else {
                              DisplaySnackbar.show(
                                  isError: true,
                                  context,
                                  credentialsDidnotMatchStr,
                                  icon: Icons.error_outline);
                            }
                            setState(() {
                              loader = false;
                            });
                          });
                        } catch (e) {
                          setState(() {
                            loader = false;
                          });
                          // ignore: use_build_context_synchronously
                          DisplaySnackbar.show(
                              context, failedStr + e.toString());
                        }
                      });
                    }
                  },
                  child: const Text(loginStr),
                ),
                CustomSizedBox(
                  height: 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(data: dontHaveAccountStr),
                    CustomInkwell(
                      child: CustomText(
                        data: registerStr,
                        color: primaryColor,
                      ),
                      onTap: () {
                        RouteGenerator.navigateToPage(
                            context, Routes.signupRoute);
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
