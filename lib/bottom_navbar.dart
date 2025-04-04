import 'package:car_rental_system/add_car_form.dart';
import 'package:car_rental_system/chat_page.dart';
import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/get_started.dart';
import 'package:car_rental_system/home.dart';
import 'package:car_rental_system/profile_page.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

class BottomNavbar1 extends StatefulWidget {
  const BottomNavbar1({super.key});

  @override
  State<BottomNavbar1> createState() => _BottomNavbar1State();
}

class _BottomNavbar1State extends State<BottomNavbar1> {
  PageController pageController = PageController();
  int index = 0;
  
  List<BottomNavigationBarItem> bottomNavItemList = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.car_rental_outlined),
      label: '', // Empty string to remove label
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.chat_bubble_outlined),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      label: '',
    ),
  ];

  List<Widget> widgets = [
    const Home(),
    const AddCarForm(),
    const ChatPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        children: widgets,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      bottomNavigationBar:Theme(
        data: ThemeData(
          splashFactory: NoSplash.splashFactory, // Disable splash effect
        ),child: BottomNavigationBar(
        items: bottomNavItemList,
        elevation: 2,
        currentIndex: index,
        backgroundColor: Colors.white,
        unselectedItemColor: greyColor,
        selectedItemColor: primaryColor,
        type: BottomNavigationBarType.fixed, // Ensures all icons are visible
        showSelectedLabels: false, // Hides selected labels
        showUnselectedLabels: false,
         // Hides unselected labels
        onTap: (value) {
          setState(() {
            index = value;
            pageController.jumpToPage(value); // Sync PageView with navbar
            // OR use pageController.animateToPage(value, duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
      ),),
    );
  }
  
 
}