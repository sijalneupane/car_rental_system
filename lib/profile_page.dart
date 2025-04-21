import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/dialog_box.dart';
import 'package:car_rental_system/core/util/get_user_info.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/custom_profile_options_button.dart';
import 'package:car_rental_system/model/users.dart';
import 'package:car_rental_system/widgets/custom_app_bar.dart';
import 'package:car_rental_system/widgets/custom_circle_avatar.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/padding_for_all_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Users? users;
  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserIdAndInfo();
  }

  getUserIdAndInfo() async {
    userId = await GetUserInfo().getUserId();
    if (userId != null) {
      Users? user1 = await GetUserInfo().getUserDetails(userId!);
      setState(() {
        users = user1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: PaddingForAllPages(
            child: Column(
              children: [
                CustomAppBar(
                  middleChild: CustomText(
                    data: profileStr,
                    isPageTitle: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                  child: CustomCircleAvatar(
                    backgroundImage: const NetworkImage(
                        "https://randomuser.me/api/portraits/men/85.jpg"),
                    radius: 40,
                  ),
                ),
                CustomText(
                  data: "Robert Albert",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                CustomText(
                  data: "sijalneupane5@gmail.com",
                  color: greyColor,
                ),
                CustomSizedBox(
                  height: 0.03,
                ),
                CustomProfileOptionsButton(
                  icon: Icons.edit,
                  data: editProfileStr,
                  onPressed: () {
                    RouteGenerator.navigateToPage(context, Routes.signupRoute,
                        arguments: users);
                  },
                ),
                CustomProfileOptionsButton(
                  icon: Icons.add_box_rounded,
                  data: addCarDetailsStr,
                  onPressed: () {
                    RouteGenerator.navigateToPage(
                        context, Routes.addCarDetailsRoute);
                  },
                ),
                CustomProfileOptionsButton(
                  icon: FontAwesomeIcons.car,
                  data: viewCarDetailsStr,
                  onPressed: () {
                    RouteGenerator.navigateToPage(
                        context, Routes.viewCarListRoute);
                  },
                ),
                CustomProfileOptionsButton(
                  icon: FontAwesomeIcons.idCard,
                  data: licenseStr,
                  onPressed: () {},
                ),
                CustomProfileOptionsButton(
                  icon: FontAwesomeIcons.passport,
                  data: passportStr,
                  onPressed: () {},
                ),
                CustomProfileOptionsButton(
                  icon: Icons.history,
                  data: myBookingStr,
                  onPressed: () {},
                ),
                CustomProfileOptionsButton(
                  icon: Icons.settings,
                  data: settingStr,
                  onPressed: () {
                    RouteGenerator.navigateToPage(
                        context, Routes.settingsRoute,arguments: users);
                  },
                ),
                CustomProfileOptionsButton(
                  icon: Icons.exit_to_app,
                  data: logoutStr,
                  onPressed: () {
                    DialogBox.showConfirmBox(
                        context: context,
                        title: logoutStr,
                        message: logoutConfirmStr,
                        onCancelPressed: () {},
                        onOkPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool logoutFromFirebaseGoogleLogin =
                              await signOut(context: context);
                          if (logoutFromFirebaseGoogleLogin) {
                            prefs.setBool("rememberMe", false);
                            print("-------------------Logging out throught The firebase google account");
                            RouteGenerator.navigateToPageWithoutStack(
                                context, Routes.loginRoute,
                                arguments: true);
                          }else{
                            print("#################### Logging out throught The register database account");
                          RouteGenerator.navigateToPageWithoutStack(
                              context, Routes.loginRoute,
                              arguments: true);
                          }
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      DialogBox.showAlertBox(
          context: context,
          title: "Logout Failed",
          message: "Logout From googleaccount failed",
          onOkPressed: () {});
      return false;
    }
  }
}
