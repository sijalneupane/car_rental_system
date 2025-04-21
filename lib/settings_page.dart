import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/model/users.dart';
import 'package:car_rental_system/widgets/custom_app_bar.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  Users? users;
  SettingsPage({super.key, this.users});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
bool? isBiometricEnabled ;
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBiometricEnabledStatus();
  }
getBiometricEnabledStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isBiometricEnabled = prefs.getBool('isBiometricEnabled') ?? false;
    setState(() {
      this.isBiometricEnabled = isBiometricEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              middleChild: CustomText(
                data: settingStr,
                isPageTitle: true,
              ),
              hasBackButton: true,
            ),
            CustomSizedBox(height: 0.02),
            SwitchListTile.adaptive(
                inactiveThumbColor: secondaryColor,
                activeColor: Colors.white,
                inactiveTrackColor: Colors.white,
                activeTrackColor: secondaryColor,
                controlAffinity: ListTileControlAffinity.platform,
                // selectedTileColor: ,
                applyCupertinoTheme: true,
                value: isBiometricEnabled??false,
                onChanged: (value) async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    isBiometricEnabled = value;
                  });
                  prefs.setBool('isBiometricEnabled', value);
                },
                title: Row(
                  children: [
                   const Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: const Icon(Icons.fingerprint),
                    ),
                    CustomText(data: 'Biometric Authentication'),
                  ],
                  // subtitle: CustomText(
                  //     data: 'Use biometric authentication for quick access'),
                ),
                ),
          ],
        ),
      ),
    );
  }
}
