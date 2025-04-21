import 'dart:ui';

import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/get_user_info.dart';
import 'package:car_rental_system/core/util/hide_keyboard.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/model/users.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_inkwell.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  String email;
  ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  Users? users;
  String? userId;
  // @override
  // void initState() {
  //   super.initState();
  //   getUserIdAndInfo();
  // }

  // getUserIdAndInfo() async {
  //   userId = await GetUserInfo().getUserId();
  //   if (userId != null) {
  //     Users? user1 = await GetUserInfo().getUserDetails(userId!);
  //     setState(() {
  //       users = user1;
  //     });
  //   }
  // }
  Future<void> changePassword(String newPassword) async {
    try {
      final collection = FirebaseFirestore.instance.collection('Register');
      final querySnapshot =
          await collection.where('email', isEqualTo: widget.email).get();

      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await collection.doc(docId).update({'password': newPassword});
        DisplaySnackbar.show(context, 'Password updated successfully');
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      DisplaySnackbar.show(context, 'Error updating password: $e');
    }
  }

  // TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool visible1 = false;
  bool visible2 = false;
  bool rememberMe = false;
  bool loader=false;
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
      body: Stack(children: [
        _ui(),
        loader ? Loader.backdropFilter(context) : SizedBox()
      ]),
    );
  }
  Widget _ui(){
    return Form(
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
                  suffixIcon: CustomNoBorderIconButton(
                    icon: visible2
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    iconColor: primaryColor,
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
                        HideKeyboard.hideKeyboard(context);
                        setState(() {
                            loader=false;
                          });
                        try {
                          changePassword(_passwordController.text);
                        RouteGenerator.navigateToPageWithoutStack(
                            context, Routes.loginRoute);
                        } catch (e) {
                          DisplaySnackbar.show(context,
                              'Error updating password: $e');
                        
                        }finally{
                          setState(() {
                            loader=false;
                          });
                        }
                      }
                    },
                    child: const Text(resetPasswordStr)),
              ],
            ),
          ),
        ),
      );
  }
}
