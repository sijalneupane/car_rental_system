import 'dart:io';

import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/hide_keyboard.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/model/users.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_image_assets.dart';
import 'package:car_rental_system/widgets/custom_image_picker.dart';
import 'package:car_rental_system/widgets/custom_inkwell.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signup extends StatefulWidget {
  Users? user;
  Signup({super.key, this.user});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        // user?.getIdTokenResult()
        await user?.getIdToken().then((value) {
          print("<----Goggle Token::$value");
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  Future<void> storeInRegisters(Users user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("Register")
        .where("email", isEqualTo: user.email)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        // DisplaySnackbar.show(
        //     // ignore: use_build_context_synchronously
        //     context,
        //     " ${user.email} is already used");
        throw Exception(" ${user.email} is already used");
      }
    });
    await firestore.collection("Register").add(user.toJson());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user?.name ?? "";
      _emailAddressController.text = widget.user?.email ?? "";
      _passwordController.text = widget.user?.password ?? "";
      userId = widget.user?.userId ?? "";
    }
  }

  String? userId;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visible = false;
  bool loader = false;
  // File? _selectedImage;
  bool isTermsAndConditionedAgreed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(userId);
    return Scaffold(
        body: Stack(
      children: [
        ui(),
        loader ? Loader.backdropFilter(context) : const SizedBox()
      ],
    ));
  }

  //widget for form
  Widget ui() => SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBackPageIcon(),
                  CustomSizedBox(
                    height: 0.02,
                  ),
                  CustomText(
                    data: userId != null ? updateProfieStr : createAccountStr,
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
                      } else if (!nameRegex.hasMatch(p0)) {
                        return validateNameRegexStr;
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
                  // CustomImagePicker(
                  //   labelText: carImageLabelStr,
                  //   afterPickingImage: (imageFile) {
                  //     setState(() {
                  //       _selectedImage = imageFile; // Store the selected image
                  //     });
                  //   },
                  //   validator: (imageFile) {
                  //     if (imageFile == null) {
                  //       return imageValidationStr;
                  //     }
                  //     double imageLength =
                  //         imageFile.lengthSync() / (1024 * 1024);
                  //     String fileExtension =
                  //         imageFile.path.split('.').last.toLowerCase();
                  //     if (!allowedExtensions.contains(fileExtension)) {
                  //       return imageExtensionsValidationStr;
                  //     }
                  //     if (imageLength > 4) {
                  //       return imageSizeValidationStr;
                  //     }
                  //     return null; // Validation passed
                  //   },
                  // ),
                  userId == null
                      ? Row(
                          children: [
                            Checkbox(
                              value: isTermsAndConditionedAgreed,
                              onChanged: (bool? value) {
                                setState(
                                  () {
                                    isTermsAndConditionedAgreed =
                                        value! ? true : false;
                                  },
                                );
                              },
                            ),
                            CustomText(
                              data: agreeTermsAndConditionStr,
                              fontSize: 16,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  CustomSizedBox(
                    height: 0.03,
                  ),
                  CustomElevatedbutton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (userId != null) {
                            isTermsAndConditionedAgreed = true;
                          }
                          if (!isTermsAndConditionedAgreed) {
                            DisplaySnackbar.show(
                                context, notAgreedToTermsAndConditionsMessage);
                            return;
                          }
                          HideKeyboard.hideKeyboard(context);
                          setState(() {
                            loader = true;
                          });
                          Future.delayed(const Duration(seconds: 2), () async {
                            Users user = Users(
                              name: _nameController.text.trim(),
                              email: _emailAddressController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            try {
                              await storeInRegisters(user);
                              setState(() {
                                loader = false;
                              });
                              RouteGenerator.navigateToPage(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  Routes.loginRoute);
                            } catch (e) {
                              setState(() {
                                loader = false;
                              });
                              // ignore: use_build_context_synchronously
                              DisplaySnackbar.show(context, e.toString());
                            }
                          });
                        }
                      },
                      child: const Text(registerStr)),
                  CustomSizedBox(
                    height: 0.03,
                  ),
                  userId == null
                      ? Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                CustomText(data: orStr),
                                const Expanded(child: Divider()),
                              ],
                            ),
                            CustomSizedBox(
                              height: 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomElevatedbutton(
                                  onPressed: () async {
                                    try {
                                      User? user = await signInWithGoogle(
                                          context: context);
                                      if (user != null) {
                                        // Users users = Users(email: user.email,name: user.displayName,);
                                        RouteGenerator
                                            .navigateToPageWithoutStack(context,
                                                Routes.bottomNavbarRoute);
                                      }
                                    } catch (e) {
                                      print(e.toString());
                                      DisplaySnackbar.show(
                                          context, e.toString(),
                                          isError: true);
                                    }
                                  },
                                  backgroundColor: Colors.white,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: CustomImageAssets(
                                    name: googleLogoPath,
                                    height: 40,
                                  ),
                                ),
                                CustomElevatedbutton(
                                  onPressed: () {},
                                  backgroundColor: Colors.white,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: CustomImageAssets(
                                    name: facebookLogoPath,
                                    height: 40,
                                  ),
                                )
                              ],
                            ),
                            CustomSizedBox(
                              height: 0.03,
                            ),
                          ],
                        )
                      : const SizedBox(),
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
