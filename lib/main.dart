import 'package:car_rental_system/car_booking_page.dart';
import 'package:car_rental_system/bottom_navbar.dart';
import 'package:car_rental_system/car_details_page.dart';
import 'package:car_rental_system/firebase_options.dart';
import 'package:car_rental_system/login.dart';
import 'package:car_rental_system/splash_screen.dart';
import 'package:car_rental_system/upload_image_demo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: CloudinaryUploadWithDio() ,
      home: SplashScreen() ,
      // home: CarDetailsPage(),
      // home: BookingPage(),
      // home: BottomNavbar1(),
      // home: LoginPgae(),
    );
  }
}
