import 'dart:io';

import 'package:car_rental_system/car_booking_page.dart';
import 'package:car_rental_system/bottom_navbar.dart';
import 'package:car_rental_system/car_details_page.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/firebase_options.dart';
import 'package:car_rental_system/login.dart';
import 'package:car_rental_system/splash_screen.dart';
import 'package:car_rental_system/POC_upload_image_demo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<NavigatorState> firebaseNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late AndroidNotificationChannel channel;

  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
    requestNotificationPermissions();
    initNotifications();
    configureFirebaseMessaging();
    checkForInitialMessage(); // ✅ handles notification tap when app is terminated
  }

  Future<void> initNotifications() async {
    // Create the Android notification channel
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Initialize native Android and iOS notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');  // Using default Flutter icon name

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // ✅ handles local notification tap
        firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
      },
    );
  }

  Future<void> requestNotificationPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    // For both Android & iOS
    final status = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    
    print('User granted permission: ${status.authorizationStatus}');
  }

  void configureFirebaseMessaging() {
    // For foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (notification != null) {
        print('Message also contained a notification: ${notification.title}');
        
        try {
          // Show the notification in the foreground
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                priority: Priority.high,
                // Use default Flutter app icon
                icon: '@mipmap/ic_launcher',
              ),
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
          );
          print('Successfully displayed notification');
        } catch (e) {
          print('Error showing notification: $e');
        }
      }
    });

    // For notifications opened while app is in background (not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A notification was opened from the background state!');
      // ✅ Navigate to notification screen when notification is tapped from background
      firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
    });
  }

  void initializeFirebaseMessaging() async {
    // Get FCM token
    String? token = await messaging.getToken();
    print("FCM TOKEN: $token");
    
    // Subscribe to topics if needed
    // await FirebaseMessaging.instance.subscribeToTopic('general');
  }

  // ✅ Check for notification tap when app is terminated
  Future<void> checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print('App was launched by clicking on a notification!');
      firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: firebaseNavigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Car Rental App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



// import 'dart:io';

// import 'package:car_rental_system/car_booking_page.dart';
// import 'package:car_rental_system/bottom_navbar.dart';
// import 'package:car_rental_system/car_details_page.dart';
// import 'package:car_rental_system/core/util/route_const.dart';
// import 'package:car_rental_system/core/util/route_generator.dart';
// import 'package:car_rental_system/firebase_options.dart';
// import 'package:car_rental_system/login.dart';
// import 'package:car_rental_system/splash_screen.dart';
// import 'package:car_rental_system/POC_upload_image_demo.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
// }

// main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// final GlobalKey<NavigatorState> firebaseNavigatorKey =
//     GlobalKey<NavigatorState>();
// final GlobalKey<ScaffoldMessengerState> scaffoldKey =
//     GlobalKey<ScaffoldMessengerState>();

// class _MyAppState extends State<MyApp> {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   Future<void> initNotifications() async {
//     // Initialize native Android and iOS notifications
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/launcher_icon');

//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (details) {
//         // ✅ handles local notification tap
//         firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     initializeFirebaseMessaging();
//     requestNotificationPermissions();
//     initNotifications();
//     configureFirebaseMessaging();
//     checkForInitialMessage(); // ✅ handles notification tap when app is terminated
//   }

//   Future<void> requestNotificationPermissions() async {
//     // if (Platform.isIOS) {
//     //   final bool? isAllowed = await flutterLocalNotificationsPlugin
//     //       .resolvePlatformSpecificImplementation<
//     //           IOSFlutterLocalNotificationsPlugin>()
//     //       ?.requestPermissions(
//     //         alert: true,
//     //         badge: true,
//     //         sound: true,
//     //       );

//     //   print('Notification permission status on iOS: $isAllowed');
//     // } else if (Platform.isAndroid) {
//     final status = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     //}
//   }

//   void configureFirebaseMessaging() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       showNotification(
//         message.notification?.title ?? '',
//         message.notification?.body ?? '',
//       );
//       //       RemoteNotification notification = message.notification;
//       // AndroidNotification android = message.notification.android!;
//       //       // If `onMessage` is triggered with a notification, construct our own
//       // // local notification to show to users using the created channel.
//       // if (notification != null && android != null) {
//       //   flutterLocalNotificationsPlugin.show(
//       //       notification.hashCode,
//       //       notification.title,
//       //       notification.body,
//       //       NotificationDetails(
//       //         android: AndroidNotificationDetails(
//       //           channel.id,
//       //           channel.name,
//       //           channel.description,
//       //           icon: android?.smallIcon,
//       //           // other properties...
//       //         ),
//       //       ));
//       // }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // ✅ Navigate to notification screen when notification is tapped from background
//       firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
//     });
//   }

//   void showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'high_importance_channel',
//       'High Importance Notifications',
//       channelDescription: 'This channel is used for important notifications.',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//     );
// /* This is setup for ios*/
//     // const DarwinNotificationDetails iosNotificationDetails =
//     //     DarwinNotificationDetails(
//     //   presentAlert: true,
//     //   presentBadge: true,
//     //   presentSound: true,
//     // );

//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       // iOS: iosNotificationDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails,
//     );
//   }

//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   initializeFirebaseMessaging();
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //     print('Got a message whilst in the foreground!');
//   //     print('Message data: ${message.data}');

//   //     if (message.notification != null) {
//   //       print('Message also contained a notification: ${message.notification}');
//   //     }
//   //   });
//   // }

//   initializeFirebaseMessaging() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     messaging.getToken().then((value) {
//       print("TOKEN IS :: :: $value");
//     });
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     print('User granted permission: ${settings.authorizationStatus}');
//   }

//   // ✅ Check for notification tap when app is terminated
//   Future<void> checkForInitialMessage() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
//     }
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: firebaseNavigatorKey,
//       onGenerateRoute: RouteGenerator.generateRoute,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         scaffoldBackgroundColor: Colors.white,
//         useMaterial3: true,
//       ),
//       debugShowCheckedModeBanner: false,
//       // home: CloudinaryUploadWithDio() ,
//       home: SplashScreen(),
//       // home: CarDetailsPage(),
//       // home: BookingPage(),
//       // home: BottomNavbar1(),
//       // home: LoginPgae(),
//     );
//   }
// }
